// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppScreenshotCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var attributes: Attributes
		public var relationships: Relationships

		public enum `Type`: String, Codable, CaseIterable {
			case appScreenshots
		}

		public struct Attributes: Codable {
			public var fileSize: Int
			public var fileName: String

			public init(fileSize: Int, fileName: String) {
				self.fileSize = fileSize
				self.fileName = fileName
			}
		}

		public struct Relationships: Codable {
			public var appScreenshotSet: AppScreenshotSet

			public struct AppScreenshotSet: Codable {
				public var data: Data

				public struct Data: Codable, Identifiable {
					public var type: `Type`
					public var id: String

					public enum `Type`: String, Codable, CaseIterable {
						case appScreenshotSets
					}

					public init(type: `Type`, id: String) {
						self.type = type
						self.id = id
					}
				}

				public init(data: Data) {
					self.data = data
				}
			}

			public init(appScreenshotSet: AppScreenshotSet) {
				self.appScreenshotSet = appScreenshotSet
			}
		}

		public init(type: `Type`, attributes: Attributes, relationships: Relationships) {
			self.type = type
			self.attributes = attributes
			self.relationships = relationships
		}
	}

	public init(data: Data) {
		self.data = data
	}
}
