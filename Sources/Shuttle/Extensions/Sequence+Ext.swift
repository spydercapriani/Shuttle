//
//  Sequence+Ext.swift
//  Shuttle
//

import Foundation

// MARK: Convert Arrays to Sets
public extension Array where Element: Hashable {
    
    var uniques: Set<Element> {
        Set(self)
    }
}

// MARK: Convert Sets to Arrays
public extension Set {
    
    var array: [Element] {
        Array(self)
    }
}
