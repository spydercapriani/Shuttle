//
//  BundleIDs+API.swift
//  Shuttle
//

import Foundation
import Get

// MARK: BundleID - Identifiable
public extension Identifiable where Self == BundleID {
    
    static func id(_ id: ID) async throws -> BundleID {
        try await AppStoreConnect.v1
            .bundleIDs.id(id).get()
            .value.data
    }
}

// MARK: BundleID - Nameable
extension BundleID: Nameable {
    
    public var name: String {
        self.attributes?.name ?? ""
    }
    
    public static func named(_ name: String) async throws -> BundleID {
        guard
            let bundleId = try await AppStoreConnect.v1
                .bundleIDs.get(parameters: .init(filterName: [name]))
                .value.data
                .first
        else {
            throw APIError.unacceptableStatusCode(404)
        }
        return bundleId
    }
}

// MARK: BundleID - UniquelyIdentifiable
extension BundleID: UniquelyIdentifiable {
    
    public var uuid: String {
        self.attributes?.identifier ?? ""
    }
    
    public static func identifer(_ identifier: String) async throws -> BundleID {
        guard
            let bundleId = try await AppStoreConnect.v1
                .bundleIDs.get(parameters: .init(filterIdentifier: [identifier]))
                .value.data
                .first
        else {
            throw APIError.unacceptableStatusCode(404)
        }
        return bundleId
    }
}

// MARK: BundleID - CRUD Actions
public extension BundleID {
    
    static func create(
        name: BundleID.Name,
        platform: BundleIDPlatform,
        identifier: BundleID.Identifier,
        seedID: String? = nil
    ) async throws -> BundleID {
        let body: BundleIDCreateRequest = .init(
            name: name,
            platform: platform,
            identifier: identifier,
            seedID: seedID
        )
        return try await AppStoreConnect.v1
            .bundleIDs.post(body)
            .value.data
    }
    
    static func delete(_ id: BundleID.ID) async throws {
        try await AppStoreConnect.v1
            .bundleIDs.id(id)
            .delete.value
    }
    
    func delete() async throws {
        try await Self.delete(self.id)
    }
    
    static func modify(
        name: BundleID.Name,
        forId id: BundleID.ID
    ) async throws -> BundleID {
        let body: BundleIDUpdateRequest = .init(
            id: id,
            name: name
        )
        
        return try await AppStoreConnect.v1
            .bundleIDs.id(id)
            .patch(body)
            .value.data
    }
    
    func modify(
        name: BundleID.Name
    ) async throws -> BundleID {
        try await Self.modify(name: name, forId: self.id)
    }
}

// MARK: BundleID - Capabilities
public extension BundleID {
    
    func enable(
        type: CapabilityType,
        settings: [CapabilitySetting]? = nil
    ) async throws {
        _ = try await BundleIDCapability.enable(
            type: type,
            settings: settings,
            for: self
        )
    }
    
    func enable(_ capabiltity: BundleIDCapability) async throws {
        guard
            let type = capabiltity.attributes?.capabilityType
        else {
            throw APIError.unacceptableStatusCode(400)
        }
        
        _ = try await enable(
            type: type,
            settings: capabiltity.attributes?.settings
        )
    }
}

// MARK: BundleIDs - All
public extension Array where Element == BundleID {
    
    static var all: [BundleID] {
        get async throws {
            try await AppStoreConnect.v1
                .bundleIDs.get()
                .value.data
        }
    }
}

// MARK: BundleID - By Profile
public extension BundleID {
    
    static func forProfileID(_ id: Profile.ID) async throws -> BundleID {
        try await AppStoreConnect.v1
            .profiles.id(id)
            .bundleID.get()
            .value.data
    }
    
    static func forProfileName(_ name: Profile.Name) async throws -> BundleID {
        let profile = try await Profile.named(name)
        return try await forProfile(profile)
    }
    
    static func forProfile(_ profile: Profile) async throws -> BundleID {
        try await forProfileID(profile.id)
    }
}

// MARK: BundleIDs - By Platform
public extension Array where Element == BundleID {
    
    static func bundleIds(forPlatform platform: BundleIDPlatform...) async throws -> [BundleID] {
        try await AppStoreConnect.v1
            .bundleIDs.get(parameters: .init(filterPlatform: platform))
            .value.data
    }
}
