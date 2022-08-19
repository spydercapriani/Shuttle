//
//  UpdateDevice.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct UpdateDevice: AsyncCommand {
    
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
        
        @Flag(
            name: "disable",
            help: "Disable the device"
        )
        var disable: Bool
    }
    
    let help = "This command helps register devices to the developers portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let deviceName = signature.deviceName
        let deviceUDID = signature.deviceUDID ?? context.console.ask("Device UDID:")
        
        var existingDevice: Device!
        do {
            context.console.info("Checking if \(deviceUDID) is already registered...")
            existingDevice = try await Device.udid(deviceUDID)
            
            context.console.success("\(existingDevice.name) exists!")
            var updateName: Bool = false
            if let deviceName = signature.deviceName,
                existingDevice.name != deviceName {
                updateName = context.console.confirm("Would you like to update the name of this device to \"\(deviceName)\"?")
            }
            
            existingDevice = try await existingDevice.update(
                name: updateName ? deviceName : nil,
                status: signature.disable ? .disabled : .enabled
            )
            context.console.success("Successfully updated \(existingDevice.name)!")
        } catch {
            guard !signature.disable else { return }
            existingDevice = try await Device.register(
                name: deviceName ?? context.console.ask("Device Name:"),
                udid: deviceUDID,
                platform: .ios
            )
            context.console.success("Successfully registered \(existingDevice.name)")
        }
        try printInfo(for: existingDevice, using: context)
        
        guard signature.disable else { return }
        try await Self.refreshInvalidProfiles(
            for: existingDevice,
            using: context
        )
    }
    
    static func refreshInvalidProfiles(for device: Device, using context: CommandContext) async throws {
        context.console.print("Refreshing invalid profiles...")
        let profiles: Set<Profile> = try await .invalid
        guard !profiles.isEmpty else { return }
        
        let progressBar = context.console.progressBar(title: "Refreshing invalid profiles...")
        progressBar.start()
        let updatedProfiles = try await profiles .concurrentCompactMap { profile -> Profile? in
            var devices: Set<Device> = try await .devices(forProfile: profile)
            if devices.contains(device) {
                devices.remove(device)
                return try await profile.update(
                    bundleId: nil,
                    devices: devices,
                    certificates: nil
                )
            } else {
                return nil
            }
        }
        progressBar.succeed()
        context.console.success("Successfully refreshed \(updatedProfiles.count) profiles")
    }
}
