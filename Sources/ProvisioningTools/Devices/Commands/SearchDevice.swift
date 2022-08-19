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
    }
    
    let help = "Checks which profiles device is assigned to"
    
    func run(using context: CommandContext, signature: Signature) async throws {
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
        try printInfo(for: device, using: context)
        context.console.info("Profiles:", newLine: true)
        profiles.forEach { profile in
            context.console.info("* \(profile.name)")
        }
    }
}

