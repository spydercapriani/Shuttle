//
//  Playground.swift
//  ShuttleTool
//

import Foundation
import ConsoleKit
import ProvisioningTools

@available(macOS 12, *)
@main
struct ShuttleTool: AsyncCommandGroup {
    
    let commands: [String : AnyAsyncCommand] = [
        "token": TokenCommand(),
        "provision": Provisioning(),
    ]
    
    let help = "Collection of Tools for interacting with App Store Connect"
    
    static func main() async throws {
        let console: Console = Terminal()
        let input = CommandInput(arguments: CommandLine.arguments)
        let group = ShuttleTool()
        try await console.run(group, input: input)
    }
}

extension CommandInput: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = String
    
    public init(arrayLiteral elements: String...) {
        self.init(arguments: elements)
    }
}
