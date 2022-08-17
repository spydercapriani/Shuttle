//
//  SearchDevice.swift
//  
//
//  Created by Danny Gilbert on 8/15/22.
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct SearchDevice: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "deviceId",
            short: "d",
            help: "Search by Device UDID"
        )
        var deviceUDID: String?
        
        @Option(
            name: "deviceName",
            short: "n",
            help: "Search by Device Name"
        )
        var deviceName: String?
        
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
    
    let help = "Checks which profiles device is assigned to"
    
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
        
        let device: Device
        if let udid = signature.deviceUDID {
            device = try await .udid(udid)
        } else if let name = signature.deviceName {
            device = try await .named(name)
        } else {
            let choice = context.console.choose("Search for device by:", from: ["name", "udid"])
            switch choice {
            case "name":
                let name = context.console.ask("Device Name:")
                device = try await .named(name)
            case "udid":
                let udid = context.console.ask("Device UDID:")
                device = try await .udid(udid)
            default:
                throw CommandError.missingCommand
            }
        }
        
        let profiles: Set<Profile> = try await .profiles(forDeviceID: device.id)
        context.console.print("Device Info:")
        try Devices.printInfo(for: device, using: context)
        context.console.info("Profiles:", newLine: true)
        profiles.forEach { profile in
            context.console.info("* \(profile.name)")
        }
    }
}

