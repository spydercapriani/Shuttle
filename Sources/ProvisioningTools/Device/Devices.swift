//
//  Devices.swift
//  ShuttleTool
//

import Foundation
import ConsoleKit

public struct Devices: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "register": RegisterCommand(),
        "enroll": EnrollCommand(),
    ]
    
    public let help = "Assists with App Store Connect Devices"
}
