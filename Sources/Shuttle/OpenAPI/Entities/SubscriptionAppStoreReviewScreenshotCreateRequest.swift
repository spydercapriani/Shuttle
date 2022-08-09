// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionAppStoreReviewScreenshotCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var attributes: Attributes
		public var relationships: Relationships

		public enum `Type`: String, Codable, CaseIterable {
			case subscriptionAppStoreReviewScreenshots
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
			public var subscription: Subscription

			public struct Subscription: Codable {
				public var data: Data

				public struct Data: Codable, Identifiable {
					public var type: `Type`
					public var id: String

					public enum `Type`: String, Codable, CaseIterable {
						case subscriptions
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

			public init(subscription: Subscription) {
				self.subscription = subscription
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
