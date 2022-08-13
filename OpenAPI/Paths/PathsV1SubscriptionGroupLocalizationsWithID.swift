// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.SubscriptionGroupLocalizations {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/subscriptionGroupLocalizations/{id}`
		public let path: String

		public func get(fieldsSubscriptionGroupLocalizations: [FieldsSubscriptionGroupLocalizations]? = nil, include: [Include]? = nil) -> Request<Shuttle.SubscriptionGroupLocalizationResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsSubscriptionGroupLocalizations, include), id: "subscriptionGroupLocalizations-get_instance")
		}

		private func makeGetQuery(_ fieldsSubscriptionGroupLocalizations: [FieldsSubscriptionGroupLocalizations]?, _ include: [Include]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder(explode: false)
			encoder.encode(fieldsSubscriptionGroupLocalizations, forKey: "fields[subscriptionGroupLocalizations]")
			encoder.encode(include, forKey: "include")
			return encoder.items
		}

		public enum FieldsSubscriptionGroupLocalizations: String, Codable, CaseIterable {
			case customAppName
			case locale
			case name
			case state
			case subscriptionGroup
		}

		public enum Include: String, Codable, CaseIterable {
			case subscriptionGroup
		}

		public func patch(_ body: Shuttle.SubscriptionGroupLocalizationUpdateRequest) -> Request<Shuttle.SubscriptionGroupLocalizationResponse> {
			Request(method: "PATCH", url: path, body: body, id: "subscriptionGroupLocalizations-update_instance")
		}

		public var delete: Request<Void> {
			Request(method: "DELETE", url: path, id: "subscriptionGroupLocalizations-delete_instance")
		}
	}
}