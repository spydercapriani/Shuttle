//
//  Devices.swift
//  ProvisioningTools
//

import Foundation
import ConsoleKit
import ProvisioningAPI

public struct Devices: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "register": RegisterDevice(),
        "enroll": EnrollDevice(),
        "update": UpdateDevice(),
        "search": SearchDevices(),
        "disable": DisableDevices(),
    ]
    
    public let help = "Assists with App Store Connect Devices"
}

func printInfo(
    for device: Device,
    using context: CommandContext
) throws {
    guard
        let attributes = device.attributes
    else { return }
    context.console.info(try attributes.prettyPrinted)
}
