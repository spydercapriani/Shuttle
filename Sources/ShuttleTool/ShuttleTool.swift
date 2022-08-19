//
//  ShuttleTool.swift
//  ShuttleTool
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningTools

@main
struct ShuttleTool: AsyncCommandGroup {
    
    let commands: [String : AnyAsyncCommand] = [
        "token": TokenCommand(),
        "provision": Provisioning(),
    ]
    
    let help = "Collection of Tools for interacting with App Store Connect"
    
    private static var config: AppleJWT {
        get {
            do { return try fetchConfig(from: configFileLocation) }
            catch { return createConfig(using: Terminal()) }
        }
        set { storeConfig(newValue) }
    }
    
    init(_ token: AppleJWT) {
        AppStoreConnect.token = token
    }
    
    static func main() async throws {
        let token: AppleJWT = {
            if
                let issuerID = ProcessInfo.processInfo.environment["issuer_id"],
                let keyID = ProcessInfo.processInfo.environment["key_id"],
                let key = ProcessInfo.processInfo.environment["key"]
            {
                return .init(
                    issuerID: issuerID,
                    keyID: keyID,
                    privateKey: key
                )
            } else {
                return config
            }
        }()
        
        let console: Console = Terminal()
        let input = CommandInput(arguments: CommandLine.arguments)
        let group = ShuttleTool(token)
        console.info("Using Key \(token.keyID)")
        try await console.run(group, input: input)
    }
    
    private static func fetchConfig(from url: URL) throws -> AppleJWT {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(AppleJWT.self, from: data)
    }

    private static func createConfig(using console: Console) -> AppleJWT {
        enum KeyMethod: String, CaseIterable, CustomStringConvertible {
            case secureInput = "Secure Input"
            case file = "File Location"
            
            var description: String { self.rawValue }
        }
        
        let issuerID = console.ask("App Store Connect Issuer ID")
        let keyID = console.ask("App Store Connnect Key ID")
        let keyMethod = console.choose("How would you like to provide the key?", from: KeyMethod.allCases)
        
        let key: P8PrivateKey = {
            switch keyMethod {
            case .secureInput:
                console.info("Enter your key without the header/footer...")
                let privateKey = console.ask("Private Key", isSecure: true)
                return privateKey
            case .file:
                var key: P8PrivateKey = ""
                repeat {
                    let file = URL(fileURLWithPath: console.ask("Enter location of .p8 file"))
                    do {
                        key = try AppleJWT.privateKey(from: file)
                    } catch {
                        console.error("Error finding private key at \(file.path)")
                        console.error(error.localizedDescription)
                    }
                } while key.isEmpty && console.confirm("Try again?")
                return key
            }
        }()
        let token = AppleJWT(
            issuerID: issuerID,
            keyID: keyID,
            privateKey: key
        )
        storeConfig(token)
        return token
    }

    static let configFileLocation = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent(".shuttle", isDirectory: true)
        .appendingPathComponent("config")
        .appendingPathExtension("json")

    private static func storeConfig(_ token: AppleJWT) {
        let console = Terminal()
        do {
            try JSONEncoder()
                .encode(token)
                .write(to: configFileLocation)
        } catch {
            console.error("Failed to store config!")
            console.error(error.localizedDescription)
        }
    }
}
