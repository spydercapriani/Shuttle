// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppClipDefaultExperienceLocalizationUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case appClipDefaultExperienceLocalizations
		}

		public struct Attributes: Codable {
			public var subtitle: String?

			public init(subtitle: String? = nil) {
				self.subtitle = subtitle
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
