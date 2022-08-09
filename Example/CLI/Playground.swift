//
//  Playground.swift
//  
//

import Foundation
import ConsoleKit

@available(macOS 12, *)
@main
struct Playground: AsyncCommandGroup {
    
    let commands: [String : AnyAsyncCommand] = [
        "token": TokenCommand(),
        "register": RegisterCommand(),
        "enroll": EnrollCommand()
    ]
    
    let help = "Playground CLI App"
    
    static func main() async throws {
        let console: Console = Terminal()
        let input = CommandInput(arguments: CommandLine.arguments)
        let group = Playground()
        try await console.run(group, input: input)
    }
}
