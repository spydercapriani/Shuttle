//
//  Devices+API.swift
//  Shuttle
//

import Foundation
import Get

// MARK: Device - Identifiable
public extension Identifiable where Self == Device {
    
    static func id(_ id: ID) async throws -> Device {
        try await AppStoreConnect.v1
            .devices.id(id).get()
            .value.data
    }
}

// MARK: Device - Nameable
extension Device: Nameable {
    
    public var name: String {
        self.attributes?.name ?? ""
    }
    
    public static func named(_ name: String) async throws -> Device {
        guard
            let device = try await AppStoreConnect.v1
                .devices.get(parameters: .init(filterName: [name]))
                .value.data
                .first
        else {
            throw APIError.unacceptableStatusCode(404)
        }
        return device
    }
}

// MARK: Device - UniquelyIdentifiable
extension Device: UniquelyIdentifiable {
    
    public var uuid: String {
        self.attributes?.udid ?? ""
    }
    
    public static func udid(_ udid: String) async throws -> Device {
        guard
            let device = try await AppStoreConnect.v1
                .devices.get(parameters: .init(filterUdid: [udid]))
                .value.data
                .first
        else {
            throw APIError.unacceptableStatusCode(404)
        }
        return device
    }
}

// MARK: Device - Register / Update
public extension Device {
    
    static func register(
        name: Device.Name,
        udid: Device.Identifier,
        platform: BundleIDPlatform
    ) async throws -> Device {
        let body = DeviceCreateRequest(
            name: name,
            udid: udid,
            platform: platform
        )
        return try await AppStoreConnect.v1
            .devices.post(body)
            .value.data
    }
    
    static func update(
        name: Device.Name?,
        status: Device.Status,
        forID id: Device.ID
    ) async throws -> Device {
        let body: DeviceUpdateRequest = .init(
            id: id,
            name: name,
            status: status
        )
        return try await AppStoreConnect.v1
            .devices.id(id)
            .patch(body)
            .value.data
    }
    
    func update(
        name: Device.Name? = nil,
        status: Device.Status
    ) async throws -> Device {
        try await Device.update(
            name: name,
            status: status,
            forID: self.id
        )
    }
    
    var enable: Void {
        get async throws {
            _ = try await update(status: .enabled)
        }
    }
    
    var disable: Void {
        get async throws {
            _ = try await update(status: .disabled)
        }
    }
}

// MARK: Devices - All
public extension Array where Element == Device {
    
    static var all: [Device] {
        get async throws {
            try await AppStoreConnect.v1
                .devices.get()
                .value.data
        }
    }
    
    static var enabled: [Device] {
        get async throws {
            try await all
                .filter { $0.attributes?.status == .enabled }
        }
    }
    
    static var disabled: [Device] {
        get async throws {
            try await all
                .filter { $0.attributes?.status == .disabled }
        }
    }
}

// MARK: - Devices - By Platform
public extension Array where Element == Device {
    
    static func devices(
        forPlatform platform: BundleIDPlatform...
    ) async throws -> [Device] {
        try await AppStoreConnect.v1
            .devices.get(parameters: .init(
                filterPlatform: platform
            ))
            .value.data
    }
}

// MARK: Devices - By Profile
public extension Array where Element == Device {
    
    static func devices(forID id: Profile.ID) async throws -> [Device] {
        try await AppStoreConnect.v1
            .profiles.id(id)
            .devices.get()
            .value.data
    }
    
    static func devices(forProfile profile: Profile) async throws -> [Device] {
        try await devices(forName: profile.name)
    }
    
    static func devices(forName name: Profile.Name) async throws -> [Device] {
        let profile = try await Profile.named(name)
        return try await devices(forProfile: profile)
    }
}
