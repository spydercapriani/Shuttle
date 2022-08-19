//
//  Profiles.swift
//  Provisioning Tools
//

import Foundation
import ConsoleKit

public struct Profiles: AsyncCommandGroup {
    
    public let commands: [String : AnyAsyncCommand] = [
        "refresh": RefreshProfile(),
    ]
    
    public let help = "Tools for dealing with App Store Connect Profiles"
}
