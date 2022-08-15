//
//  Provisioning.swift
//  ShuttleTool
//
//  Created by Danny Gilbert on 8/12/22.
//

import Foundation
import ConsoleKit

public struct Provisioning: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "devices": Devices(),
        "profiles": Profiles(),
    ]
    
    public let help = "Assists with App Store Connect Provisioning Actions"
    
    public init() { }
}
