//
//  Profiles.swift
//  Provisioning Tools
//

import Foundation
import ConsoleKit

public struct Profiles: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "devices": ProfileDevice()
    ]
    
    public let help = "Assists with App Store Connect Profiles"
}
