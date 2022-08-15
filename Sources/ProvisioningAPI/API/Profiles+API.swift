//
//  Profiles+API.swift
//  Shuttle
//

import Foundation
import Get
import Shuttle

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
            .get().download(using: AppStoreConnect.client.wrappedValue)
            .value
    }
}

// MARK: Profile - CRUD Actions
public extension Profile {
    
    static func create(
        name: Profile.Name,
        type: Profile.Attributes.ProfileType,
        bundleId: BundleID,
        devices: Set<Device>,
        certificates: Set<Certificate>
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
        devices: Set<Device.ID>,
        certificates: Set<Certificate.ID>
    ) async throws -> Profile {
        let body = ProfileCreateRequest(
            name: name,
            type: type,
            bundleId: bundleId,
            devices: devices.array,
            certificates: certificates.array
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
        devices: Set<Device>? = nil,
        certificates: Set<Certificate>? = nil,
        forProfile profile: Profile
    ) async throws -> Profile {
        let bundleIDTask = Task { () -> BundleID.ID in
            if let bundleId = bundleId {
                return bundleId.id
            } else {
                return try await BundleID.forProfile(profile).id
            }
        }
        let certificatesTask = Task { () -> Set<Certificate.ID> in
            if let certificates = certificates {
                return certificates
                    .map(\.id)
                    .uniques
            } else {
                return try await Set<Certificate>
                    .certificates(forProfile: profile)
                    .map(\.id)
                    .uniques
            }
        }
        let devicesTask = Task { () -> Set<Device.ID> in
            if let devices = devices {
                return devices
                    .map(\.id)
                    .uniques
            } else {
                return try await Set<Device>
                    .devices(forProfile: profile)
                    .map(\.id)
                    .uniques
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
        bundleId: BundleID?,
        devices: Set<Device>?,
        certificates: Set<Certificate>?,
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
        bundleId: BundleID?,
        devices: Set<Device>?,
        certificates: Set<Certificate>?,
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
    
    func update(
        bundleId: BundleID?,
        devices: Set<Device>?,
        certificates: Set<Certificate>?
    ) async throws -> Profile {
        try await Self.update(
            bundleId: bundleId,
            devices: devices,
            certificates: certificates,
            forProfile: self
        )
    }
}

// MARK: Profile - Devices - Enroll
public extension Profile {
    
    func enroll(_ devices: Set<Device>) async throws -> Profile {
        var profileDevices: Set<Device> = try await .devices(forProfile: self)
        profileDevices.formUnion(Set(devices))
        return try await self.update(
            bundleId: nil,
            devices: profileDevices,
            certificates: nil
        )
    }
    
    func enroll(_ device: Device) async throws -> Profile {
        try await enroll(Set([device]))
    }
    
    func remove(_ device: Device) async throws -> Profile {
        var devices: Set<Device> = try await .devices(forProfile: self)
        devices.remove(device)
        return try await update(
            bundleId: nil,
            devices: devices,
            certificates: nil
        )
    }
    
    func remove(_ devices: Set<Device>) async throws -> Profile {
        var profileDevices: Set<Device> = try await .devices(forProfile: self)
        profileDevices.subtract(devices)
        return try await update(
            bundleId: nil,
            devices: profileDevices,
            certificates: nil
        )
    }
    
    func enroll(_ certificates: Set<Certificate>) async throws -> Profile {
        var profileCertificates: Set<Certificate> = try await .certificates(forProfile: self)
        profileCertificates.formUnion(Set(certificates))
        return try await self.update(
            bundleId: nil,
            devices: nil,
            certificates: profileCertificates
        )
    }
    
    func enroll(_ certificate: Certificate) async throws -> Profile {
        try await enroll(Set([certificate]))
    }
    
    func remove(_ certificate: Certificate) async throws -> Profile {
        var certificates: Set<Certificate> = try await .certificates(forProfile: self)
        certificates.remove(certificate)
        return try await update(
            bundleId: nil,
            devices: nil,
            certificates: certificates
        )
    }
    
    func remove(_ certificates: Set<Certificate>) async throws -> Profile {
        var profileCertificates: Set<Certificate> = try await .certificates(forProfile: self)
        profileCertificates.subtract(certificates)
        return try await update(
            bundleId: nil,
            devices: nil,
            certificates: profileCertificates
        )
    }
}

// MARK: Profile - All - Set
public extension Set where Element == Profile {
    
    static var all: Set<Profile> {
        get async throws {
            try await AppStoreConnect.v1
                .profiles.get()
                .value.data
                .uniques
        }
    }
    
    static var active: Set<Profile> {
        get async throws {
            try await all
                .filter { $0.attributes?.profileState == .active }
        }
    }
    
    static var invalid: Set<Profile> {
        get async throws {
            try await all
                .filter { $0.attributes?.profileState == .invalid }
        }
    }
}

// MARK: Profile - All - Array
public extension Array where Element == Profile {
    
    static func all(
        sortedBy: AppStoreConnect.V1.Profiles.GetParameters.Sort? = nil
    ) async throws -> [Profile] {
        try await AppStoreConnect.v1
            .profiles.get(
                parameters: .init(
                    sort: sortedBy
                )
            )
            .value.data
    }
    
    static func active(
        sortedBy: AppStoreConnect.V1.Profiles.GetParameters.Sort? = nil
    ) async throws -> [Profile] {
        try await all(sortedBy: sortedBy)
            .filter { $0.attributes?.profileState == .active }
    }
    
    static func invalid(
        sortedBy: AppStoreConnect.V1.Profiles.GetParameters.Sort? = nil
    ) async throws -> [Profile] {
        try await all(sortedBy: sortedBy)
            .filter { $0.attributes?.profileState == .invalid }
    }
}

// MARK: Profiles - By Profile Type - Set
public extension Set where Element == Profile {
    
    static func profiles(ofType type: Profile.Attributes.ProfileType...) async throws -> Set<Profile> {
        try await AppStoreConnect.v1
            .profiles.get(parameters: .init(
                filterProfileType: type
            ))
            .value.data
            .uniques
    }
}

// MARK: Profiles - By Profile Type - Array
public extension Array where Element == Profile {
    
    static func profiles(ofType type: Profile.Attributes.ProfileType...) async throws -> [Profile] {
        try await AppStoreConnect.v1
            .profiles.get(parameters: .init(
                filterProfileType: type
            ))
            .value.data
    }
}

// MARK: Profiles - By BundleID - Array
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

// MARK: Profiles - By BundleID - Set
public extension Set where Element == Profile {
    
    static func profiles(forID id: BundleID.ID) async throws -> Set<Profile> {
        try await [Profile].profiles(forID: id).uniques
    }
    
    static func profiles(forName name: BundleID.Name) async throws -> Set<Profile> {
        let bundleId = try await BundleID.named(name)
        return try await profiles(forBundleID: bundleId)
    }
    
    static func profiles(forBundleID bundleId: BundleID) async throws -> Set<Profile> {
        try await profiles(forID: bundleId.id)
    }
}

// MARK: Profiles - By Device - Set
public extension Set where Element == Profile {
    
    static func profiles(forDeviceID id: Device.ID) async throws -> Set<Profile> {
        let allProfiles: Set<Profile> = try await .all
        
        var profiles = Set<Profile>()
        try await allProfiles.concurrentForEach { profile in
            let devices: Set<Device> = try await .devices(forProfile: profile)
            if devices.map(\.id).contains(id) {
                profiles.insert(profile)
            }
        }
        return profiles
    }
    
    static func profiles(forDeviceName name: Device.Name) async throws -> Set<Profile> {
        let device = try await Device.named(name)
        return try await profiles(forDeviceID: device.id)
    }
    
    static func profiles(forDeviceUDID udid: Device.Identifier) async throws -> Set<Profile> {
        let device = try await Device.udid(udid)
        return try await profiles(forDeviceID: device.id)
    }

    static func profiles(forDevice device: Device) async throws -> Set<Profile> {
        try await profiles(forDeviceID: device.id)
    }
}
