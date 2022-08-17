//
//  ListDevices.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct ListDevices: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "profile",
            short: "p",
            help: "Name of Provisioning Profile to check for enrolled device. <If none given, looks for all registered devices>"
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
    
    let help = "Checks on device enrollment status."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        guard let issuerId = signature.issuerId else {
            throw CommandError.missingRequiredArgument("--issuerId <appStoreConnect_issuer_id>")
        }
        guard let keyId = signature.keyId else {
            throw CommandError.missingRequiredArgument("--keyId <appStoreConnect_key_id>")
        }
        guard let path = signature.key else {
            throw CommandError.missingRequiredArgument("--key <AppStoreConnect.p8_key_file>")
        }
        let key = URL(fileURLWithPath: path)
        let provider = try AppleTokenProvider(
            issuerId: issuerId,
            keyId: keyId,
            key: key
        )
        AppStoreConnect.client = AppStoreConnectClient(provider)
        
        let devices: Set<Device>
        if let profileName = signature.profileName {
            let profile = try await Profile.named(profileName)
            devices = try await .devices(forProfile: profile)
        } else {
            devices = try await .all
        }
        
        try devices.forEach { device in
            try Devices.printInfo(for: device, using: context)
        }
        context.console.info("Found \(devices.count) devices.")
    }
}
