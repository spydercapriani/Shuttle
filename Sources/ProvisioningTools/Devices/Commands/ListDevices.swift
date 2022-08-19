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
        
        @Option(
        )
        
        @Option(
        )
        
        @Option(
        )
    }
    
    let help = "Checks on device enrollment status."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        }
        }
        
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
