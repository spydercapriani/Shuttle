//
//  RegisterCommand.swift
//
//

import Foundation
import ConsoleKit
import Shuttle
import Get
import ProvisioningAPI

struct RegisterCommand: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "udid",
            short: "u",
            help: "Unique Device Identifier"
        )
        var deviceUDID: String?

        @Option(
            name: "name",
            short: "d",
            help: "Name of the device"
        )
        var deviceName: String?
        
        @Option(name: "issuerId", short: "i", help: "Issuer Id")
        var issuerId: String?
        
        @Option(name: "keyId", short: "k", help: "Key Id")
        var keyId: String?
        
        @Option(name: "key", short: "f", help: "Location of key", completion: CompletionAction.files())
        var key: String?
    }
    
    let help = "This command helps register devices to the developers portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        guard
            let issuerId = signature.issuerId
        else {
            throw CommandError.missingRequiredArgument("--issuerId <appStoreConnect_issuer_id>")
        }
        guard
            let keyId = signature.keyId
        else {
            throw CommandError.missingRequiredArgument("--keyId <appStoreConnect_key_id>")
        }
        guard
            let path = signature.key
        else {
            throw CommandError.missingRequiredArgument("--key <AppStoreConnect.p8_key_file>")
        }
        let key = URL(fileURLWithPath: path)
        let provider = try AppleTokenProvider(
            issuerId: issuerId,
            keyId: keyId,
            key: key
        )
        AppStoreConnect.client = APIClient(token: provider)
        
        let deviceName = signature.deviceName ?? context.console.ask("Name of Device:")
        let deviceUDID = signature.deviceUDID ?? context.console.ask("Device UDID:")
        
        do {
            context.console.info("Checking if \(deviceUDID) is already registered...")
            let existingDevice = try await Device.udid(deviceUDID)
            context.console.success("\(existingDevice.name) already exists!")
            guard
                context.console.confirm("Would you like to enroll \(existingDevice.name) to all profiles?")
            else { return }
            try await enrollToAllProfiles(existingDevice, using: context)
            return
        } catch {
            let device = try await Device.register(
                name: deviceName,
                udid: deviceUDID,
                platform: .ios
            )
            context.console.success("Successfully registered \(device.name)")
            guard
                context.console.confirm("Would you like to enroll \(device.name) to all profiles?")
            else { return }
            try await enrollToAllProfiles(device, using: context)
        }
    }
    
    func enrollToAllProfiles(
        _ device: Device,
        using context: CommandContext
    ) async throws {
        let profiles: Set<Profile> = try await .all
        try await profiles.concurrentForEach { profile in
            context.console.info("Enrolling \(device.name) to \(profile.name)")
            let updatedProfile = try await profile.enroll(device)
            context.console.success("Successfully enrolled \(device.name) to \(updatedProfile.name)")
        }
    }
}
