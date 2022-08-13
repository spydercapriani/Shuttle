//
//  BundleIDCapability+API.swift
//  ProvisioningAPI
//

import Foundation
import Shuttle
import Get
import Shuttle

// MARK: BundleIDCapability - Enable / Disable
public extension BundleIDCapability {
    
    static func enable(
        type: CapabilityType,
        settings: [CapabilitySetting]? = nil,
        forID id: BundleID.ID
    ) async throws -> BundleIDCapability {
        let body: BundleIDCapabilityCreateRequest = .init(
            type: type,
            settings: settings,
            id: id
        )
        return try await AppStoreConnect.v1
            .bundleIDCapabilities
            .post(body)
            .value.data
    }
    
    static func enable(
        type: CapabilityType,
        settings: [CapabilitySetting]? = nil,
        for bundleId: BundleID
    ) async throws -> BundleIDCapability {
        try await BundleIDCapability.enable(
            type: type,
            settings: settings,
            forID: bundleId.id
        )
    }
    
    var disable: Void {
        get async throws {
            try await AppStoreConnect.v1
                .bundleIDCapabilities.id(self.id)
                .delete.value
        }
    }
    
    static func modify(
        type: CapabilityType?,
        settings: [CapabilitySetting]?,
        forID id: BundleIDCapability.ID
    ) async throws -> BundleIDCapability {
        let body: BundleIDCapabilityUpdateRequest = .init(
            id: id,
            type: type,
            settings: settings
        )
        return try await AppStoreConnect.v1
            .bundleIDCapabilities.id(id)
            .patch(body)
            .value.data
    }
    
    func modify(
        type: CapabilityType?,
        settings: [CapabilitySetting]?
    ) async throws -> BundleIDCapability {
        try await Self.modify(
            type: type,
            settings: settings,
            forID: self.id
        )
    }
}

// MARK: BundleIDCapability - By BundleID
public extension Array where Element == BundleIDCapability {
    
    static func capabilities(forID id: BundleID.ID) async throws -> [BundleIDCapability] {
        try await AppStoreConnect.v1
            .bundleIDs.id(id)
            .bundleIDCapabilities.get()
            .value.data
    }
    
    static func capabilities(forBundleID bundleId: BundleID) async throws -> [BundleIDCapability] {
        try await capabilities(forID: bundleId.id)
    }
    
    static func capabilities(forName name: BundleID.Name) async throws -> [BundleIDCapability] {
        let bundleId = try await BundleID.named(name)
        return try await capabilities(forBundleID: bundleId)
    }
}
