//
//  Client.swift
//  Shuttle
//

import Foundation
import Get

public extension AppStoreConnect {
    /// Default API Client to be used for all App Store Connect API requests.
    static var client: APIClient!
}

public extension APIClient {
    
    convenience init(
        baseURL: URL?,
        sessionConfiguration: URLSessionConfiguration = .default,
        provider: JWTToken
    ) {
        self.init(
            configuration: .init(
                baseURL: baseURL,
                sessionConfiguration: sessionConfiguration,
                delegate: JWTRequestsAuthenticator(provider)
            )
        )
    }
    
    convenience init(
        token: AppleJWT
    ) {
        self.init(
            baseURL: URL(string: "https://api.appstoreconnect.apple.com"),
            provider: token
        )
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .iso8601)
        
        self.configuration.decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            let context = DecodingError.Context(codingPath: [], debugDescription: "Date Decoding Error - \(dateStr)")
            throw DecodingError.typeMismatch(Date.self, context)
        }
    }
}

public extension Request where Response: Decodable {
    
    func send(using client: APIClient = AppStoreConnect.client) async throws -> Response {
        try await client.send(self).value
    }
}

public extension Request where Response == Void {
    
    func send(using client: APIClient = AppStoreConnect.client) async throws {
        try await client.send(self)
    }
}

public extension Request where Response == URL {
    
    func download(using client: APIClient = AppStoreConnect.client) async throws -> Response {
        try await client.download(for: self).location
    }
}
