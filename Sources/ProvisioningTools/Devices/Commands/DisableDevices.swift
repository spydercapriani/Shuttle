//
//  DisableDevices.swift
//  
//
//  Created by Danny Gilbert on 8/18/22.
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct DisableDevices: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Argument(
            name: "devices",
            help: "l",
            completion: .files(withExtensions: ["json"])
        )
        var list: String
    }
    
    let help = "This command helps disable devices on the developer portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let url = URL(fileURLWithPath: signature.list)
        let data = try Data(contentsOf: url)
        let devices = try JSONDecoder().decode([Device.Attributes].self, from: data)
        
        guard context.console.confirm("Would you like to proceed with disabling \(devices.count.description) devices?") else { return }
        
        let portalDevices: [Device] = await devices.concurrentCompactMap {
            do {
                return try await Device.named($0.name!)
            } catch {
                context.console.error("Failed to locate \($0.name!)!")
                context.console.error(error.localizedDescription)
            }
            return nil
        }
        
        var count: Int = 0
        await portalDevices.concurrentForEach { device in
            context.console.print("Disabling \(device.name)")
            do {
                try await device.disable
                count += 1
                context.console.success("Disabled \(device.name)")
            } catch {
                context.console.error("Failed to disable \(device.name)!")
                context.console.error(error.localizedDescription)
            }
            
            do {
                context.console.print("Attempting to refresh profiles for device")
                try await UpdateDevice.refreshInvalidProfiles(
                    for: device,
                    using: context
                )
            } catch {
                context.console.error("Failed to disable \(device.name)!")
                context.console.error(error.localizedDescription)
            }
        }
        
        context.console.success("Disabled \(count.description) devices!")
        
        // TODO: Refresh profiles associated with these devices
    }
}

