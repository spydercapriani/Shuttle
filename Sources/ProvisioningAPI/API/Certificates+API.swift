//
//  Certificates+API.swift
//  Shuttle
//

import Foundation
import Get
import Shuttle

// MARK: Certificate - Identifiable
public extension Identifiable where Self == Certificate {
    
    static func id(_ id: ID) async throws -> Certificate {
        try await AppStoreConnect.v1
            .certificates.id(id).get()
            .value.data
    }
}

// MARK: Certificate - Nameable
extension Certificate: Nameable {
    
    public var name: String {
        self.attributes?.name ?? ""
    }
    
    public static func named(_ name: String) async throws -> Certificate {
        guard
            let certificate = try await AppStoreConnect.v1
                .certificates.get(parameters: .init(filterDisplayName: [name]))
                .value.data
                .first
        else {
            throw APIError.unacceptableStatusCode(404)
        }
        return certificate
    }
}

// MARK: Certificate - Download
public extension Certificate {
    
    func download() async throws -> URL {
        try await AppStoreConnect.v1
            .certificates.id(self.id)
            .get().download(using: AppStoreConnect.client.wrappedValue)
            .value
    }
}

// MARK: Certificate - Create / Revoke
public extension Certificate {
    
    static func create(
        csrContent: String,
        type: CertificateType
    ) async throws -> Certificate {
        let body: CertificateCreateRequest = .init(
            csrContent: csrContent,
            type: type
        )
        return try await AppStoreConnect.v1
            .certificates.post(body)
            .value.data
    }
    
    static func revoke(_ id: Certificate.ID) async throws {
        try await AppStoreConnect.v1
            .certificates.id(id)
            .delete.value
    }
    
    func revoke() async throws {
        try await Certificate.revoke(self.id)
    }
}

// MARK: Certificates - All
public extension Set where Element == Certificate {
    
    static var all: Set<Certificate> {
        get async throws {
            try await AppStoreConnect.v1
                .certificates.get()
                .value.data
                .uniques
        }
    }
    
    static var active: Set<Certificate> {
        get async throws {
            try await all
                .filter {
                    guard
                        let expirationDate = $0.attributes?.expirationDate
                    else {
                        return false
                    }
                    return expirationDate > Date.now
                }
        }
    }
    
    static var expired: Set<Certificate> {
        get async throws {
            try await all
                .filter {
                    guard
                        let expirationDate = $0.attributes?.expirationDate
                    else {
                        return false
                    }
                    return expirationDate < Date.now
                }
        }
    }
}

// MARK: Certificates - By Certificate Type
public extension Set where Element == Certificate {
    
    static func certificates(ofType type: CertificateType...) async throws -> Set<Certificate> {
        try await AppStoreConnect.v1
            .certificates.get(parameters: .init(filterCertificateType: type))
            .value.data
            .uniques
    }
}

// MARK: Certificates - By Profile
public extension Set where Element == Certificate {
    
    static func certificates(forID id: Profile.ID) async throws -> Set<Certificate> {
        try await AppStoreConnect.v1
            .profiles.id(id)
            .certificates.get()
            .value.data
            .uniques
    }
    
    static func certificates(forProfile profile: Profile) async throws -> Set<Certificate> {
        try await certificates(forID: profile.id)
    }
    
    static func certificates(forName name: Profile.Name) async throws -> Set<Certificate> {
        let profile = try await Profile.named(name)
        return try await certificates(forProfile: profile)
    }
}
