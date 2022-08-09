// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppStoreVersionExperimentUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case appStoreVersionExperiments
		}

		public struct Attributes: Codable {
			public var name: String?
			public var trafficProportion: Int?
			public var isStarted: Bool?

			public init(name: String? = nil, trafficProportion: Int? = nil, isStarted: Bool? = nil) {
				self.name = name
				self.trafficProportion = trafficProportion
				self.isStarted = isStarted
			}

			private enum CodingKeys: String, CodingKey {
				case name
				case trafficProportion
				case isStarted = "started"
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
