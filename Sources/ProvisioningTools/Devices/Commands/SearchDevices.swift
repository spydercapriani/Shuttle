//
//  SearchDevices.swift
//  
//
//  Created by Danny Gilbert on 8/15/22.
//

import Foundation
import ConsoleKit
import Shuttle
import ProvisioningAPI

struct SearchDevices: AsyncCommand {
    
    struct Signature: CommandSignature {
        @Option(
            name: "deviceId",
            short: "d",
            help: "Search by Device UDID"
        )
        var deviceUDID: String?
        
        @Option(
            name: "deviceName",
            short: "n",
            help: "Search by Device Name"
        )
        var deviceName: String?
        
        @Option(
            name: "profile",
            short: "p",
            help: "Name of Provisioning Profile to check for enrolled device. <If none given, looks for all registered devices>"
        )
        var profileName: Profile.Name?
        
        @Option(
            name: "platform",
            short: "P",
            help: "Filter devices by Platform <IOS|MAC_OS>",
            completion: .values(of: BundleIDPlatform.self)
        )
        var platform: BundleIDPlatform?
        
        @Option(
            name: "models",
            short: "m",
            help: "Filter devices by array of models"
        )
        var models: [String]?
        
        @Option(
            name: "olderThan",
            short: "d",
            help: "Filter by devices older than date <MM/dd/yyyy>"
        )
        var olderThan: String?
        
        @Option(
            name: "newerThan",
            short: "D",
            help: "Filter by devices newer than date <MM/dd/yyyy>"
        )
        var newerThan: String?
        
        @Option(
            name: "deviceClass",
            short: "c",
            help: "Filter devices by Device Class <APPLE_WATCH|IPAD|IPHONE|IPOD|APPLE_TV|MAC",
            completion: .values(of: Device.DeviceClass.self)
        )
        var deviceClass: Device.DeviceClass?
        
        @Option(
            name: "status",
            short: "s",
            help: "Filter devices by Device Status <ENABLED|DISABLED>",
            completion: .values(of: Device.Status.self)
        )
        var status: Device.Status?
        
        @Option(
            name: "output",
            short: "o",
            help: "Output results to file location",
            completion: .files()
        )
        var location: String?
    }
    
    let help = "Checks which profiles device is assigned to"
    
    func run(using context: CommandContext, signature: Signature) async throws {
        if let date = Date.from(signature.olderThan) {
            guard
                context.console.confirm("Check for devices older than \(date.formatted(date: .long, time: .omitted))?")
            else { return }
        }
        if let date = Date.from(signature.newerThan) {
            guard
                context.console.confirm("Check for devices newer than \(date.formatted(date: .long, time: .omitted))?")
            else { return }
        }
        
        var devices: Set<Device>
        if let profileName = signature.profileName {
            let profile = try await Profile.named(profileName)
            devices = try await .devices(forProfile: profile)
        } else {
            devices = try await .all
        }
        
        devices = devices
            .filter {
                guard let device = $0.attributes else { return false }
                var result = true
                
                // Filter by UDID
                if let deviceUDID = device.udid,
                   let filteredDeviceUDID = signature.deviceUDID
                {
                    return deviceUDID == filteredDeviceUDID
                }
                
                // Filter by Device Name
                if let deviceName = device.name,
                   let filteredDeviceName = signature.deviceName
                {
                    return deviceName == filteredDeviceName
                }
                
                // Filter by Device Class
                if result,
                   let deviceClass = device.deviceClass,
                   let filteredDeviceClass = signature.deviceClass
                {
                    result = deviceClass == filteredDeviceClass
                }
                // Filter by Device Platform
                if result,
                   let platform = device.platform,
                   let filteredPlatform = signature.platform
                {
                    result = platform == filteredPlatform
                }
                // Filter by Device Status
                if result,
                   let status = device.status,
                   let filteredStatus = signature.status
                {
                    result = status == filteredStatus
                }
                // Filter by Device Models
                if result,
                   let filteredModels = signature.models
                {
                    guard let model = device.model else { return false }
                    result = filteredModels.reduce(false) { partialResult, filteredModel in
                        guard !partialResult else { return partialResult }
                        return model.contains(filteredModel)
                    }
                }
                // Filter Devices added before given date
                if result,
                   let addedDate = device.addedDate,
                   let checkDate = Date.from(signature.olderThan)
                {
                    result = addedDate.isBefore(checkDate)
                }
                // Filter Devices added after given date
                if result,
                   let addedDate = device.addedDate,
                   let checkDate = Date.from(signature.newerThan)
                {
                    result = addedDate.isAfter(checkDate)
                }
                
                return result
            }
        
        let deviceList = try devices
            .compactMap { device in
                guard
                    let attributes = device.attributes
                else { return nil }
                return try attributes.prettyPrinted
            }
            .joined(separator: ",\n")
        
        let message = "Found \(devices.count) matching devices."
        context.console.info(deviceList)
        context.console.success(message)
        
        guard
            let location = signature.location,
            !devices.isEmpty
        else { return }
        let output = message + "\n" + deviceList
        if FileManager.default
            .createFile(
                atPath: location,
                contents: output.data(using: .utf8)
            ) {
            context.console.success("List available at \(location)")
        } else {
            context.console.error("Failed to write to \(location)!")
        }
    }
}

// MARK: BundleIDPlatform - LosslessStringConvertible
extension BundleIDPlatform: LosslessStringConvertible {
    
    public var description: String {
        self.rawValue
    }
    
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

// MARK: DeviceClass - LosslessStringConvertible
extension Device.DeviceClass: LosslessStringConvertible {
    
    public var description: String {
        self.rawValue
    }
    
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

// MARK: Status - LosslessStringConvertible
extension Device.Status: LosslessStringConvertible {
    
    public var description: String {
        self.rawValue
    }
    
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

// MARK: Array<String> - LosslessStringConvertible
extension Array: LosslessStringConvertible where Element == String {
    
    public init?(_ description: String) {
        self = description.split(separator: ",")
            .map(String.init)
    }
}

// MARK: - Date Helpers
extension Date {
    
    static func from(_ string: String?) -> Date? {
        guard let dateString = string else { return nil }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        formatter.dateFormat = "yyyy"
        if let date = formatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
    
    func isBefore(_ date: Date) -> Bool {
        self.compare(date) == .orderedAscending
    }
    
    func isAfter(_ date: Date) -> Bool {
        self.compare(date) == .orderedDescending
    }
}
