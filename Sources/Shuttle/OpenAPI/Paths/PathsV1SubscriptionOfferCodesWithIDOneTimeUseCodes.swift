// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.SubscriptionOfferCodes.WithID {
	public var oneTimeUseCodes: OneTimeUseCodes {
		OneTimeUseCodes(path: path + "/oneTimeUseCodes")
	}

	public struct OneTimeUseCodes {
		/// Path: `/v1/subscriptionOfferCodes/{id}/oneTimeUseCodes`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<Shuttle.SubscriptionOfferCodeOneTimeUseCodesResponse> {
			Request(method: "GET", url: path, query: parameters?.asQuery, id: "subscriptionOfferCodes-oneTimeUseCodes-get_to_many_related")
		}

		public struct GetParameters {
			public var fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]?
			public var fieldsSubscriptionOfferCodeOneTimeUseCodes: [FieldsSubscriptionOfferCodeOneTimeUseCodes]?
			public var limit: Int?
			public var include: [Include]?

			public enum FieldsSubscriptionOfferCodes: String, Codable, CaseIterable {
				case active
				case customCodes
				case customerEligibilities
				case duration
				case name
				case numberOfPeriods
				case offerEligibility
				case offerMode
				case oneTimeUseCodes
				case prices
				case subscription
				case totalNumberOfCodes
			}

			public enum FieldsSubscriptionOfferCodeOneTimeUseCodes: String, Codable, CaseIterable {
				case active
				case createdDate
				case expirationDate
				case numberOfCodes
				case offerCode
				case values
			}

			public enum Include: String, Codable, CaseIterable {
				case offerCode
			}

			public init(fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]? = nil, fieldsSubscriptionOfferCodeOneTimeUseCodes: [FieldsSubscriptionOfferCodeOneTimeUseCodes]? = nil, limit: Int? = nil, include: [Include]? = nil) {
				self.fieldsSubscriptionOfferCodes = fieldsSubscriptionOfferCodes
				self.fieldsSubscriptionOfferCodeOneTimeUseCodes = fieldsSubscriptionOfferCodeOneTimeUseCodes
				self.limit = limit
				self.include = include
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsSubscriptionOfferCodes, forKey: "fields[subscriptionOfferCodes]")
				encoder.encode(fieldsSubscriptionOfferCodeOneTimeUseCodes, forKey: "fields[subscriptionOfferCodeOneTimeUseCodes]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				return encoder.items
			}
		}
	}
}
