//
//  Nameable.swift
//  
//
//  Created by Danny Gilbert on 8/11/22.
//

import Foundation
import Get

public protocol Nameable {
    associatedtype Name
    
    var name: Name { get }
}
