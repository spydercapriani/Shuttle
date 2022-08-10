//
//  EnrollCommand.swift
//  
//

import Foundation
import ConsoleKit
import Shuttle
import Get

struct EnrollCommand: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "profile",
            short: "p",
            help: "Name of Provisioning Profile to update."
        )
        var profileName: String?
        
        @Option(
            name: "issuerId",
            short: "i",
            help: "App Store Connect API Issuer Id"
        )
        var issuerId: String?
        
        @Option(
            name: "keyId",
            short: "k",
            help: "App Store Connect API Key Id"
        )
        var keyId: String?
        
        @Option(
            name: "key",
            short: "f",
            help: "Location of App Store Connect API Key.p8 file",
            completion: .files(withExtensions: ["p8"])
        )
        var key: String?
    }
    
    let help = "This command enrolls all devices to all provisioning profiles."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let printInfo: (String...) -> Void = { strings in
            let message = strings.joined(separator: " ")
            context.console.info(message)
        }
        
        let issuerId = signature.issuerId ?? context.console.ask("Issuer ID:")
        let keyId = signature.keyId ?? context.console.ask("Key ID:")
        let key = URL(fileURLWithPath: signature.key ?? context.console.ask("Key File Location:"))
        
        let provider = try payloadProvider(
            issuerId: issuerId,
            keyId: keyId,
            key: key
        )
        AppStoreConnect.client = APIClient(token: provider)
        
        let allProfiles = try await AppStoreConnect
            .v1
            .profiles
            .get(
                parameters: .init(
                    filterName: signature.profileName == nil ? nil : [signature.profileName!],
                    filterProfileState: nil,
                    filterProfileType: nil,
                    filterID: nil,
                    sort: nil,
                    fieldsProfiles: [.name, .uuid, .profileType, .createdDate, .bundleID, .certificates],
                    limit: nil,
                    include: nil,
                    fieldsCertificates: nil,
                    fieldsDevices: nil,
                    fieldsBundleIDs: nil,
                    limitCertificates: nil,
                    limitDevices: nil
                )
            )
            .send()
            .data
        
        let allDeviceIds = try await AppStoreConnect
            .v1
            .devices
            .get()
            .send()
            .data
            .map(\.id)
        
        for profile in allProfiles {
            let json = try profile.prettyPrinted
            guard
                let profileName = profile.attributes?.name,
                let profileType = profile.attributes?.profileType
            else {
                context.console.error("Failed to get Name/ProfileType from \(json)")
                continue
            }
            
            let bundleIDTask = Task {
                try await AppStoreConnect
                    .v1
                    .profiles
                    .id(profile.id)
                    .bundleID
                    .get()
                    .send()
                    .data
            }
            
            let certificatesTask = Task {
                try await AppStoreConnect
                    .v1
                    .profiles
                    .id(profile.id)
                    .certificates
                    .get()
                    .send()
                    .data
            }
            
            let devicesTask = Task {
                try await AppStoreConnect
                    .v1
                    .profiles
                    .id(profile.id)
                    .devices
                    .get()
                    .send()
                    .data
            }
            
            let bundleId = try await bundleIDTask.value
            let certificateIds = Set(try await certificatesTask.value.map(\.id))
            let currentDeviceIds = Set(try await devicesTask.value.map(\.id))
            
            printInfo("Current Info for", profileName)
            printInfo("- BundleID: \(bundleId.attributes!.name!)")
            printInfo("- # of Certificates: \(certificateIds.count)")
            printInfo("- # of Devices: \(currentDeviceIds.count)")
            
            try await AppStoreConnect
                .v1
                .profiles
                .id(profile.id)
                .delete
                .send()
            context.console.error("Deleted \(profileName)")
            
            let newProfile = try await AppStoreConnect
                .v1
                .profiles
                .post(
                    ProfileCreateRequest(
                        data: .init(
                            type: .profiles,
                            attributes: .init(
                                name: profileName,
                                profileType: .init(rawValue: profileType.rawValue)!
                            ),
                            relationships: .init(
                                bundleID: .init(
                                    data: .init(
                                        type: .bundleIDs,
                                        id: bundleId.id
                                    )
                                ),
                                devices: .init(
                                    data: allDeviceIds.map {
                                        .init(
                                            type: .devices,
                                            id: $0
                                        )
                                    }
                                ),
                                certificates: .init(
                                    data: certificateIds.map {
                                        .init(
                                            type: .certificates,
                                            id: $0
                                        )
                                    }
                                )
                            )
                        )
                    )
                )
                .send()
                .data
            
            context.console.success("Created \(newProfile.attributes!.name!)")
        }
    }
}
