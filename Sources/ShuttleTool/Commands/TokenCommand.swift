//
//  TokenCommand.swift
//
//

import Foundation
import ConsoleKit
import AppKit
import Shuttle

struct TokenCommand: AsyncCommand {
    
    struct Signature: CommandSignature { }
    
    let help = "This command helps generate Apple JWT tokens."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let token = try AppStoreConnect.token.value
        
        if context.console.confirm("Would you like to copy your token to the clipboard?") {
            copyToClipboard(token)
            context.console.success("Token copied to clipboard!")
        } else {
            context.console.success(token)
        }
    }
    
    private func copyToClipboard(_ contents: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.writeObjects([contents as NSString])
    }
}
