// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppInlineCreate: Codable, Identifiable {
	public var type: `Type`
	public var id: String?
	public var attributes: Attributes
	public var relationships: Relationships?

	public enum `Type`: String, Codable, CaseIterable {
		case apps
	}

	public struct Attributes: Codable {
		public var bundleID: String
		public var sku: String
		public var primaryLocale: String

		public init(bundleID: String, sku: String, primaryLocale: String) {
			self.bundleID = bundleID
			self.sku = sku
			self.primaryLocale = primaryLocale
		}

		private enum CodingKeys: String, CodingKey {
			case bundleID = "bundleId"
			case sku
			case primaryLocale
		}
	}

	public struct Relationships: Codable {
		public var appStoreVersions: AppStoreVersions?
		public var appInfos: AppInfos?

		public struct AppStoreVersions: Codable {
			public var data: [Datum]?

			public struct Datum: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case appStoreVersions
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(data: [Datum]? = nil) {
				self.data = data
			}
		}

		public struct AppInfos: Codable {
			public var data: [Datum]?

			public struct Datum: Codable, Identifiable {
				public var type: `Type`
				public var id: String

				public enum `Type`: String, Codable, CaseIterable {
					case appInfos
				}

				public init(type: `Type`, id: String) {
					self.type = type
					self.id = id
				}
			}

			public init(data: [Datum]? = nil) {
				self.data = data
			}
		}

		public init(appStoreVersions: AppStoreVersions? = nil, appInfos: AppInfos? = nil) {
			self.appStoreVersions = appStoreVersions
			self.appInfos = appInfos
		}
	}

	public init(type: `Type`, id: String? = nil, attributes: Attributes, relationships: Relationships? = nil) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
	}
}
