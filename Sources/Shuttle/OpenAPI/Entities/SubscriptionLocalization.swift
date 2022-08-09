// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct SubscriptionLocalization: Codable, Identifiable {
	public var type: `Type`
	public var id: String
	public var attributes: Attributes?
	public var relationships: Relationships?
	public var links: ResourceLinks

	public enum `Type`: String, Codable, CaseIterable {
		case subscriptionLocalizations
	}

	public struct Attributes: Codable {
		public var name: String?
		public var locale: String?
		public var description: String?
		public var state: State?

		public enum State: String, Codable, CaseIterable {
			case prepareForSubmission = "PREPARE_FOR_SUBMISSION"
			case waitingForReview = "WAITING_FOR_REVIEW"
			case approved = "APPROVED"
			case rejected = "REJECTED"
		}

		public init(name: String? = nil, locale: String? = nil, description: String? = nil, state: State? = nil) {
			self.name = name
			self.locale = locale
			self.description = description
			self.state = state
		}
	}

	public struct Relationships: Codable {
		public var subscription: Subscription?

		public struct Subscription: Codable {
			public var links: Links?
			public var data: Data?

			public struct Links: Codable {
				public var this: String?
				public var related: String?

				public init(this: String? = nil, related: String? = nil) {
					self.this = this
					self.related = related
				}

				private enum CodingKeys: String, CodingKey {
					case this = "self"
					case related
				}
			}

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

			public init(links: Links? = nil, data: Data? = nil) {
				self.links = links
				self.data = data
			}
		}

		public init(subscription: Subscription? = nil) {
			self.subscription = subscription
		}
	}

	public init(type: `Type`, id: String, attributes: Attributes? = nil, relationships: Relationships? = nil, links: ResourceLinks) {
		self.type = type
		self.id = id
		self.attributes = attributes
		self.relationships = relationships
		self.links = links
	}
}
