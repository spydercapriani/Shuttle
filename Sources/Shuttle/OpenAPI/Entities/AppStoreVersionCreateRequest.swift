// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppStoreVersionCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var attributes: Attributes
		public var relationships: Relationships

		public enum `Type`: String, Codable, CaseIterable {
			case appStoreVersions
		}

		public struct Attributes: Codable {
			public var platform: Platform
			public var versionString: String
			public var copyright: String?
			public var releaseType: ReleaseType?
			public var earliestReleaseDate: Date?

			public enum ReleaseType: String, Codable, CaseIterable {
				case manual = "MANUAL"
				case afterApproval = "AFTER_APPROVAL"
				case scheduled = "SCHEDULED"
			}

			public init(platform: Platform, versionString: String, copyright: String? = nil, releaseType: ReleaseType? = nil, earliestReleaseDate: Date? = nil) {
				self.platform = platform
				self.versionString = versionString
				self.copyright = copyright
				self.releaseType = releaseType
				self.earliestReleaseDate = earliestReleaseDate
			}
		}

		public struct Relationships: Codable {
			public var app: App
			public var appStoreVersionLocalizations: AppStoreVersionLocalizations?
			public var build: Build?

			public struct App: Codable {
				public var data: Data

				public struct Data: Codable, Identifiable {
					public var type: `Type`
					public var id: String

					public enum `Type`: String, Codable, CaseIterable {
						case apps
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

			public struct AppStoreVersionLocalizations: Codable {
				public var data: [Datum]?

				public struct Datum: Codable, Identifiable {
					public var type: `Type`
					public var id: String

					public enum `Type`: String, Codable, CaseIterable {
						case appStoreVersionLocalizations
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

			public struct Build: Codable {
				public var data: Data?

				public struct Data: Codable, Identifiable {
					public var type: `Type`
					public var id: String

					public enum `Type`: String, Codable, CaseIterable {
						case builds
					}

					public init(type: `Type`, id: String) {
						self.type = type
						self.id = id
					}
				}

				public init(data: Data? = nil) {
					self.data = data
				}
			}

			public init(app: App, appStoreVersionLocalizations: AppStoreVersionLocalizations? = nil, build: Build? = nil) {
				self.app = app
				self.appStoreVersionLocalizations = appStoreVersionLocalizations
				self.build = build
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
