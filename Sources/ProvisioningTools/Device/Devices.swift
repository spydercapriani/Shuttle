//
//  Devices.swift
//  ShuttleTool
//

import Foundation
import ConsoleKit
import ProvisioningAPI

public struct Devices: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "register": RegisterDevice(),
        "enroll": EnrollDevice(),
        "update": UpdateDevice(),
    ]
    
    public let help = "Assists with App Store Connect Devices"
    
    static func printInfo(
        for device: Device,
        using context: CommandContext
    ) throws {
        guard
            let attributes = device.attributes
        else { return }
        context.console.info(try attributes.prettyPrinted)
    }
}
