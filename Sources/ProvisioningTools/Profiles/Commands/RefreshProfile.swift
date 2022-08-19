//
//  File.swift
//  
//
//  Created by Danny Gilbert on 8/18/22.
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct RefreshProfile: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "profile",
            help: "p"
        )
        var profile: String?
    }
    
    let help = "This command helps disable devices on the developer portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        var profiles: Set<Profile>
        if let name = signature.profile {
            profiles = Set([try await Profile.named(name)])
        } else {
            profiles = try await .invalid
        }
        
        
        guard context.console.confirm("Would you like to refresh \(profiles.count.description) profiles?") else { return }
        
        var count = 0
        profiles = await profiles.concurrentCompactMap { profile in
            do {
                context.console.print("Refreshing \(profile.name)")
                let updated = try await profile.refresh
                count += 1
                context.console.success("Successfully refreshed \(updated.name)")
                return updated
            } catch {
                context.console.error("Failed to refresh \(profile.name)")
                context.console.error(error.localizedDescription)
                return nil
            }
        }.uniques
        
        context.console.success("Successfully refreshed \(count.description) profiles!")
    }
}
