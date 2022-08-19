//
//  EnrollDevice.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct EnrollDevice: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "deviceId",
            short: "d",
            help: "Device UDID to enroll. <If none given, assumes all devices>"
        )
        var deviceUDID: String?
        
        @Option(
            name: "profile",
            short: "p",
            help: "Name of Provisioning Profile to enroll device in. <If none given, assumes all profiles>"
        )
        var profileName: String?
    }
    
    let help = "Checks on device enrollment status."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        var devices = Set<Device>()
        if let deviceUDID = signature.deviceUDID {
            // Target single device.
            let device: Device!
            do {
                context.console.info("Checking that \(deviceUDID) is registered...")
                device = try await Device.udid(deviceUDID)
            } catch {
                let deviceName = context.console.ask("Device Name:")
                let platform: BundleIDPlatform = .init(
                    rawValue: context.console.choose(
                        "Select your Device Platform",
                        from: BundleIDPlatform.allCases.map(\.rawValue)
                    )
                )!
                context.console.info("Registering \(deviceName)...")
                device = try await Device.register(
                    name: deviceName,
                    udid: deviceUDID,
                    platform: platform
                )
                context.console.success("Successfully registered \(device.name)!")
            }
            devices.insert(device)
        } else {
            // Target all devices.
            devices = try await .all
        }
        
        var profiles = Set<Profile>()
        if let profileName = signature.profileName {
            // Target single profile.
            profiles.insert(try await Profile.named(profileName))
        } else {
            // Target all profiles.
            profiles = try await .all
        }
        
        context.console.info("Action Summary:")
        context.console.info("  * Enrolling \(devices.count) devices")
        context.console.info("  * Across \(profiles.count) profiles")
        
        guard
            context.console.confirm("Do you wish to proceed?")
        else {
            return
        }
        
        profiles = try await profiles.concurrentMap { profile in
            try await profile.enroll(devices)
        }.uniques
        
        context.console.success("Successfully enrolled \(devices.count) devices to \(profiles.count) profiles!")
    }
}
