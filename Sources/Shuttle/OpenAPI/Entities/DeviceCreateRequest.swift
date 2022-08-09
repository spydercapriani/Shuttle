// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct DeviceCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var attributes: Attributes

		public enum `Type`: String, Codable, CaseIterable {
			case devices
		}

		public struct Attributes: Codable {
			public var name: String
			public var platform: BundleIDPlatform
			public var udid: String

			public init(name: String, platform: BundleIDPlatform, udid: String) {
				self.name = name
				self.platform = platform
				self.udid = udid
			}
		}

		public init(type: `Type`, attributes: Attributes) {
			self.type = type
			self.attributes = attributes
		}
	}

	public init(data: Data) {
		self.data = data
	}
}
