//
//  TokenCommand.swift
//
//

import Foundation
import ConsoleKit
import AppKit
import Shuttle

struct TokenCommand: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(name: "issuerId", short: "i", help: "Issuer Id")
        var issuerId: String?
        
        @Option(name: "keyId", short: "k", help: "Key Id")
        var keyId: String?
        
        @Option(name: "key", short: "f", help: "Location of key", completion: CompletionAction.files())
        var key: String?
    }
    
    let help = "This command helps generate Apple JWT tokens."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let issuerId = signature.issuerId ?? context.console.ask("Issuer ID:")
        let keyId = signature.keyId ?? context.console.ask("Key ID:")
        let key = URL(fileURLWithPath: signature.key ?? context.console.ask("Key File Location:"))
        
        let provider = try AppleTokenProvider(
            issuerId: issuerId,
            keyId: keyId,
            key: key
        )

        let token = try provider.token
        
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
