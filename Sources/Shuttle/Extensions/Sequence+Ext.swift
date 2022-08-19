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

// MARK: Async Map
public extension Sequence {
    
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        try await self.asyncForEach {
            try await values.append(transform($0))
        }

        return values
    }
    
    func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async rethrows -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }
        
        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}

// MARK: - Async ForEach
public extension Sequence {
    
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    func concurrentForEach(
        _ operation: @escaping (Element) async throws -> Void
    ) async rethrows {
        await withThrowingTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    try await operation(element)
                }
            }
        }
    }
}

// MARK: - Async CompactMap
public extension Sequence {
    
    func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T?]()
        
        try await self.asyncForEach {
            try await values.append(transform($0))
        }

        return values.compactMap { $0 }
    }
    
    func concurrentCompactMap<T>(
        _ transform: @escaping (Element) async throws -> T?
    ) async rethrows -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }
        
        return try await tasks.asyncCompactMap { task in
            try await task.value
        }
    }
}

// MARK: - Async FlatMap
public extension Sequence {
    
    func asyncFlatMap<Result: Sequence>(
        _ transform: (Element) async throws -> Result
    ) async rethrows -> [Result.Element] {
        var result: [Result.Element] = []
        try await self.asyncForEach {
            let element = try await transform($0)
            result.append(contentsOf: element)
        }
        return result
    }
    
    func asyncConcurrentFlatMap<Result: Sequence>(
        _ transform: @escaping (Element) async throws -> Result
    ) async rethrows -> [Result.Element] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }
        
        return try await tasks.asyncFlatMap { task in
            try await task.value
        }
    }
}

// MARK: - Async Reduce
public extension Sequence {
    
    func asyncReduce<Result>(
        into initialResult: Result,
        _ transform: (_ partialResult: inout Result, Element) async throws -> ()
    ) async rethrows -> Result {
        var result = initialResult
        try await self.asyncForEach {
            try await transform(&result, $0)
        }
        return result
    }
    
    func asyncReduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: (_ partialResult: Result, Element) async throws -> Result
    ) async rethrows -> Result {
        var result = initialResult
        try await self.asyncForEach {
            result = try await nextPartialResult(result, $0)
        }
        return result
    }
}
