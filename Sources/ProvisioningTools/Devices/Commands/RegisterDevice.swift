//
//  RegisterDevice.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import Shuttle
import Get
import ProvisioningAPI

struct RegisterDevice: AsyncCommand {
    
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
    }
    
    let help = "This command helps register devices to the developers portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let deviceName = signature.deviceName ?? context.console.ask("Name of Device:")
        let deviceUDID = signature.deviceUDID ?? context.console.ask("Device UDID:")
        
        do {
            context.console.info("Checking if \(deviceUDID) is already registered...")
            var existingDevice = try await Device.udid(deviceUDID)
            
            context.console.success("\(existingDevice.name) exists!")
            if existingDevice.name != deviceName,
               context.console.confirm("Would you like to update the name of this device to \"\(deviceName)\"?"){
                existingDevice = try await existingDevice.update(
                    name: deviceName,
                    status: .enabled
                )
                context.console.success("Successfully updated \(existingDevice.name)!")
                try printInfo(for: existingDevice, using: context)
            }
            guard
                context.console.confirm("Would you like to enroll \(existingDevice.name) to all profiles?")
            else { return }
            try await Self.enroll(
                existingDevice,
                to: .all,
                using: context
            )
            return
        } catch {
            let device = try await Device.register(
                name: deviceName,
                udid: deviceUDID,
                platform: .ios
            )
            context.console.success("Successfully registered \(device.name)")
            try printInfo(for: device, using: context)
            guard
                context.console.confirm("Would you like to enroll \(device.name) to all profiles?")
            else { return }
            try await Self.enroll(
                device,
                to: .all,
                using: context
            )
        }
    }
    
    static func enroll(
        _ device: Device,
        to profiles: Set<Profile>,
        using context: CommandContext
    ) async throws {
        try await profiles.concurrentForEach { profile in
            context.console.info("Enrolling \(device.name) to \(profile.name)")
            let updatedProfile = try await profile.enroll(device)
            context.console.success("Successfully enrolled \(device.name) to \(updatedProfile.name)")
        }
    }
}
