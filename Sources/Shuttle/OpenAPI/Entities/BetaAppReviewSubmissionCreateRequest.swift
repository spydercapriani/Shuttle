// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct BetaAppReviewSubmissionCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var relationships: Relationships

		public enum `Type`: String, Codable, CaseIterable {
			case betaAppReviewSubmissions
		}

		public struct Relationships: Codable {
			public var build: Build

			public struct Build: Codable {
				public var data: Data

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

				public init(data: Data) {
					self.data = data
				}
			}

			public init(build: Build) {
				self.build = build
			}
		}

		public init(type: `Type`, relationships: Relationships) {
			self.type = type
			self.relationships = relationships
		}
	}

	public init(data: Data) {
		self.data = data
	}
}
