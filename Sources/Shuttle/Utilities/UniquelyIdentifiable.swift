//
//  UniquelyIdentifiable.swift
//  Shuttle
//

import Foundation
import Get

public protocol UniquelyIdentifiable {
    associatedtype Identifier: Hashable
    
    var uuid: Identifier { get }
}
