// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct DeviceUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case devices
		}

		public struct Attributes: Codable {
			public var name: String?
			public var status: Status?

			public enum Status: String, Codable, CaseIterable {
				case enabled = "ENABLED"
				case disabled = "DISABLED"
			}

			public init(name: String? = nil, status: Status? = nil) {
				self.name = name
				self.status = status
			}
		}

		public init(type: `Type`, id: String, attributes: Attributes? = nil) {
			self.type = type
			self.id = id
			self.attributes = attributes
		}
	}

	public init(data: Data) {
		self.data = data
	}
}