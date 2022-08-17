//
//  LargeDataSet.swift
//  
//
//  Created by Danny Gilbert on 8/17/22.
//

import Foundation
import Get

public protocol LargeDataSet: Decodable {
    associatedtype Data: Decodable
    
    var data: [Data] { get }
    var links: PagedDocumentLinks { get set }
    var meta: PagingInformation? { get }
}

public extension LargeDataSet {
    
    var all: [Data] {
        get async throws {
            var response = self
            var request = self.next
            var all = self.data
            while let next = request {
                response = try await next.value
                all.append(contentsOf: response.data)
                request = response.next
            }
            return all
        }
    }
    
    var next: Request<Self>? {
        guard let next = self.links.next else { return nil }
        return .init(url: next.absoluteString)
    }
}

// MARK: Resource Limitations
public extension Int {
    
    /// Maximum number of resources that can be returned in a single App Store Connect response.
    static let maxResources: Int = 200
}

public let maxResources: ClosedRange<Int> = 1...Int.maxResources
