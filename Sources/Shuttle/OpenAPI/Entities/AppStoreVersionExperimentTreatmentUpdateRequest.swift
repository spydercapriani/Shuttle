// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppStoreVersionExperimentTreatmentUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case appStoreVersionExperimentTreatments
		}

		public struct Attributes: Codable {
			public var name: String?
			public var appIconName: String?

			public init(name: String? = nil, appIconName: String? = nil) {
				self.name = name
				self.appIconName = appIconName
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
