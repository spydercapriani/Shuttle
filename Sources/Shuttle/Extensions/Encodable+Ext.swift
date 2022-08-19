//
//  Encodable+Ext.swift
//  Shuttle
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any] {
        get throws {
            let data = try JSONEncoder().encode(self)
            guard
                let dictionary = try JSONSerialization
                    .jsonObject(
                        with: data,
                        options: .fragmentsAllowed
                    ) as? [String: Any]
            else {
                throw NSError()
            }
            return dictionary
        }
    }
    
    var prettyPrinted: String {
        get throws {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d,yyyy @ h:mm a"
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)!
        }
    }
}
