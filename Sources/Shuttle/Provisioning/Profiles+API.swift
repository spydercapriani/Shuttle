//
//  Profiles+API.swift
//  Shuttle
//

import Foundation
import Get

// MARK: Profile - Identifiable
public extension Identifiable where Self == Profile {
    
    static func id(_ id: ID) async throws -> Profile {
        try await AppStoreConnect.v1
            .profiles.id(id).get()
            .value.data
    }
}

// MARK: Profile - Nameable
extension Profile: Nameable {
    
    public var name: String {
        self.attributes?.name ?? ""
    }
    
    public static func named(_ name: String) async throws -> Profile {
        guard let profile = try await AppStoreConnect.v1.profiles.get(parameters: .init(filterName: [name])).value.data.first else {
            throw APIError.unacceptableStatusCode(404)
        }
        return profile
    }
}

// MARK: Profile - Download
public extension Profile {
    
    func download() async throws -> URL {
        try await AppStoreConnect.v1
            .profiles.id(self.id)
            .get().download(using: AppStoreConnect.client)
            .value
    }
}

// MARK: Profile - CRUD Actions
public extension Profile {
    
    static func create(
        name: Profile.Name,
        type: Profile.Attributes.ProfileType,
        bundleId: BundleID,
        devices: [Device],
        certificates: [Certificate]
    ) async throws -> Profile {
        let body = ProfileCreateRequest(
            name: name,
            type: type,
            bundleId: bundleId,
            devices: devices,
            certificates: certificates
        )
        
        return try await AppStoreConnect.v1
            .profiles.post(body)
            .value.data
    }
    
    static func create(
        name: Profile.Name,
        type: Profile.Attributes.ProfileType,
        bundleId: BundleID.ID,
        devices: [Device.ID],
        certificates: [Certificate.ID]
    ) async throws -> Profile {
        let body = ProfileCreateRequest(
            name: name,
            type: type,
            bundleId: bundleId,
            devices: devices,
            certificates: certificates
        )
        
        return try await AppStoreConnect.v1
            .profiles.post(body)
            .value.data
    }
    
    static func delete(byId id: Profile.ID) async throws {
        try await AppStoreConnect.v1
            .profiles.id(id)
            .delete.value
    }
    
    static func delete(byName name: Profile.Name) async throws {
        let profile = try await Profile.named(name)
        try await delete(profile)
    }
    
    static func delete(_ profile: Profile) async throws {
        try await delete(byId: profile.id)
    }
    
    static func update(
        bundleId: BundleID? = nil,
        devices: [Device]? = nil,
        certificates: [Certificate]? = nil,
        forProfile profile: Profile
    ) async throws -> Profile {
        let bundleIDTask = Task { () -> BundleID.ID in
            if let bundleId = bundleId {
                return bundleId.id
            } else {
                return try await BundleID.forProfile(profile).id
            }
        }
        let certificatesTask = Task { () -> [Certificate.ID] in
            if let certificates = certificates {
                return certificates
                    .map(\.id)
            } else {
                return try await [Certificate]
                    .certificates(forProfile: profile)
                    .map(\.id)
            }
        }
        let devicesTask = Task { () -> [Device.ID] in
            if let devices = devices {
                return devices
                    .map(\.id)
            } else {
                return try await [Device]
                    .devices(forProfile: profile)
                    .map(\.id)
            }
        }
        
        let bundleId = try await bundleIDTask.value
        let certificateIds = try await certificatesTask.value
        let deviceIds = try await devicesTask.value
        guard
            let profileType = profile.attributes?.profileType
        else {
            throw APIError.unacceptableStatusCode(400)
        }
        try await delete(profile)
        return try await create(
            name: profile.name,
            type: profileType,
            bundleId: bundleId,
            devices: deviceIds,
            certificates: certificateIds
        )
    }
    
    static func update(
        bundleId: BundleID? = nil,
        devices: [Device]? = nil,
        certificates: [Certificate]? = nil,
        forProfileNamed name: Profile.Name
    ) async throws -> Profile {
        let profile = try await Profile.named(name)
        return try await update(
            bundleId: bundleId,
            devices: devices,
            certificates: certificates,
            forProfile: profile
        )
    }
    
    static func update(
        bundleId: BundleID? = nil,
        devices: [Device]? = nil,
        certificates: [Certificate]? = nil,
        forProfileID id: Profile.ID
    ) async throws -> Profile {
        let profile = try await Profile.id(id)
        return try await update(
            bundleId: bundleId,
            devices: devices,
            certificates: certificates,
            forProfile: profile
        )
    }
}

// MARK: Profile - All
public extension Array where Element == Profile {
    
    static var all: [Profile] {
        get async throws {
            try await AppStoreConnect.v1
                .profiles.get()
                .value.data
        }
    }
    
    static var active: [Profile] {
        get async throws {
            try await all
                .filter { $0.attributes?.profileState == .active }
        }
    }
    
    static var invalid: [Profile] {
        get async throws {
            try await all
                .filter { $0.attributes?.profileState == .invalid }
        }
    }
}

// MARK: Profiles - By Profile Type
public extension Array where Element == Profile {
    
    static func profiles(ofType type: Profile.Attributes.ProfileType...) async throws -> [Profile] {
        try await AppStoreConnect.v1
            .profiles.get(parameters: .init(
                filterProfileType: type
            ))
            .value.data
    }
}

// MARK: Profiles - By BundleID
public extension Array where Element == Profile {
    
    static func profiles(forID id: BundleID.ID) async throws -> [Profile] {
        try await AppStoreConnect.v1
            .bundleIDs.id(id)
            .profiles.get()
            .value.data
    }
    
    static func profiles(forName name: BundleID.Name) async throws -> [Profile] {
        let bundleId = try await BundleID.named(name)
        return try await profiles(forBundleID: bundleId)
    }
    
    static func profiles(forBundleID bundleId: BundleID) async throws -> [Profile] {
        try await profiles(forID: bundleId.id)
    }
}
