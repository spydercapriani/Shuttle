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
        let key = signature.key ?? context.console.ask("Key File Location:")
        let file = URL(fileURLWithPath: key)
        let privateKey = try privateKey(from: file)

        let token = try JWT(
            keyIdentifier: keyId,
            issuerIdentifier: issuerId,
            privateKey: privateKey
        ).token
        
        if context.console.confirm("Would you like to copy your token to the clipboard?") {
            copyToClipboard(token)
            context.console.success("Token copied to clipboard!")
        } else {
            context.console.success(token)
        }
    }
}

func payloadProvider(
    issuerId: String,
    keyId: String,
    key: URL
) throws -> JWT {
    let privateKey = try privateKey(from: key)
    return JWT(
        keyIdentifier: keyId,
        issuerIdentifier: issuerId,
        privateKey: privateKey
    )
}

func privateKey(from file: URL) throws -> String {
    var privateKey = try String(contentsOf: file)
    
    // remove the header string
    let offset = String("-----BEGIN PRIVATE KEY-----").count
    let index = privateKey.index(privateKey.startIndex, offsetBy: offset+1)
    privateKey = String(privateKey.suffix(from: index))
    // remove end of line chars
    privateKey = privateKey.replacingOccurrences(of: "\n", with: "")
    // remove the tail string
    let tailWord = "-----END PRIVATE KEY-----"
    if let lowerBound = privateKey.range(of: tailWord)?.lowerBound {
        privateKey = String(privateKey.prefix(upTo: lowerBound))
    }
    return privateKey
}

func copyToClipboard(_ contents: String) {
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    pasteboard.writeObjects([contents as NSString])
}
