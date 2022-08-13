//
//  EnrollCommand.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import Shuttle
import Get
import ProvisioningAPI

struct EnrollCommand: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "deviceId",
            short: "d",
            help: "Device UDID"
        )
        var deviceUDID: String?
        
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
    
    let help = "Checks on device enrollment status."
    
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
        
        let profileName = signature.profileName ?? context.console.ask("Name of Profile:")
        context.console.info("Looking up \(profileName)...")
        var profile = try await Profile.named(profileName)
        
        if let deviceUDID = signature.deviceUDID {
            // Enroll single device to profile.
            let device: Device!
            do {
                context.console.info("Checking if \(deviceUDID) is registered...")
                device = try await Device.udid(deviceUDID)
            } catch {
                context.console.error(error.localizedDescription)
                context.console.error("Device not registered!")
                context.console.info("You can register this device via `shuttle provision devices register`")
                return
            }
            let profileDevices: Set<Device> = try await .devices(forProfile: profile)
            if profileDevices.map(\.uuid).contains(deviceUDID) {
                context.console.success("Device is already enrolled in \(profileName)!")
                return
            } else {
                profile = try await profile.enroll(Set([device]))
                context.console.success("Successfully enrolled \(device.name) to \(profile.name)")
            }
        } else {
            // Enroll all enabled devices in portal to profile.
            context.console.info("Enrolling all avaialable devices to \(profile.name)")
            let allDevices: Set<Device> = try await .enabled
            profile = try await profile.enroll(allDevices)
            context.console.success("Successfully enrolled \(allDevices.count) devices to \(profile.name)")
        }
    }
}
