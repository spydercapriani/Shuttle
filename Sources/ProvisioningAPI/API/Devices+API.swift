//
//  Devices+API.swift
//  Shuttle
//

import Foundation
import Get
import Shuttle

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

// MARK: - Devices - By Platform
public extension Set where Element == Device {

    static func devices(
        forPlatform platform: BundleIDPlatform...
    ) async throws -> Set<Device> {
        try await AppStoreConnect.v1
            .devices.get(parameters: .init(
                filterPlatform: platform
            ))
            .value.data
            .uniques
    }
}

public extension Array where Element == Device {
    
    static func devices(
        forPlatform platform: BundleIDPlatform...,
        sortedBy: AppStoreConnect.V1.Devices.GetParameters.Sort? = nil
    ) async throws -> [Device] {
        try await AppStoreConnect.v1
            .devices.get(parameters: .init(
                filterPlatform: platform,
                sort: sortedBy
            ))
            .value.data
    }
}

// MARK: Devices - All - Set
public extension Set where Element == Device {
    
    static var all: Set<Device> {
        get async throws {
            try await AppStoreConnect.v1
                .devices.get()
                .value.data
                .uniques
        }
    }
    
    static var enabled: Set<Device> {
        get async throws {
            try await all
                .filter { $0.attributes?.status == .enabled }
        }
    }
    
    static var disabled: Set<Device> {
        get async throws {
            try await all
                .filter { $0.attributes?.status == .disabled }
        }
    }
}

// MARK: Devices - All - Array
public extension Array where Element == Device {
    
    static func all(
        sortedBy: AppStoreConnect.V1.Devices.GetParameters.Sort? = nil
    ) async throws -> [Device] {
        try await AppStoreConnect.v1
            .devices.get(
                parameters: .init(
                    sort: sortedBy
                )
            )
            .value.data
    }
    
    static func enabled(
        sortedBy: AppStoreConnect.V1.Devices.GetParameters.Sort? = nil
    ) async throws -> [Device] {
        try await all(sortedBy: sortedBy)
            .filter { $0.attributes?.status == .enabled }
    }
    
    static func disabled(
        sortedBy: AppStoreConnect.V1.Devices.GetParameters.Sort? = nil
    ) async throws -> [Device] {
        try await all(sortedBy: sortedBy)
            .filter { $0.attributes?.status == .disabled }
    }
}

// MARK: Devices - By Profile
public extension Set where Element == Device {
    
    static func devices(forID id: Profile.ID) async throws -> Set<Device> {
        Set(
            try await AppStoreConnect.v1
                .profiles.id(id)
                .devices.get()
                .value.data
        )
    }
    
    static func devices(forProfile profile: Profile) async throws -> Set<Device> {
        Set(try await devices(forID: profile.id))
    }
    
    static func devices(forName name: Profile.Name) async throws -> Set<Device> {
        let profile = try await Profile.named(name)
        return Set(try await devices(forProfile: profile))
    }
}
