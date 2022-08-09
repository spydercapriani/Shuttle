//
//  RegisterCommand.swift
//
//

import Foundation
import ConsoleKit
import Shuttle
import Get

struct RegisterCommand: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "udid",
            short: "u",
            help: "Unique Device Identifier"
        )
        var deviceUDID: String?

        @Option(
            name: "name",
            short: "d",
            help: "Name of the device"
        )
        var deviceName: String?
        
        @Option(name: "issuerId", short: "i", help: "Issuer Id")
        var issuerId: String?
        
        @Option(name: "keyId", short: "k", help: "Key Id")
        var keyId: String?
        
        @Option(name: "key", short: "f", help: "Location of key", completion: CompletionAction.files())
        var key: String?
    }
    
    let help = "This command helps register devices to the developers portal."
    
    func run(using context: CommandContext, signature: Signature) async throws {
        let deviceName = signature.deviceName ?? context.console.ask("Name of Device:")
        let deviceUDID = signature.deviceUDID ?? context.console.ask("Device UDID:")
        
        let issuerId = signature.issuerId ?? context.console.ask("Issuer ID:")
        let keyId = signature.keyId ?? context.console.ask("Key ID:")
        let key = URL(fileURLWithPath: signature.key ?? context.console.ask("Key File Location:"))
        
        let provider = try payloadProvider(
            issuerId: issuerId,
            keyId: keyId,
            key: key
        )
        AppStoreConnect.client = APIClient(provider: provider)
        
        let device = try await AppStoreConnect
            .v1
            .devices
            .post(
                .init(
                    data: .init(
                        type: .devices,
                        attributes: .init(
                            name: deviceName,
                            platform: .ios,
                            udid: deviceUDID
                        )
                    )
                )
            )
            .send()
            .data
        
        context.console.success("Successfully registered \(device.attributes!.name!)")
    }
}
