// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BetaTesters.WithID.Relationships {
	public var betaGroups: BetaGroups {
		BetaGroups(path: path + "/betaGroups")
	}

	public struct BetaGroups {
		/// Path: `/v1/betaTesters/{id}/relationships/betaGroups`
		public let path: String

		public func get(limit: Int? = nil) -> Request<Shuttle.BetaTesterBetaGroupsLinkagesResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(limit), id: "betaTesters-betaGroups-get_to_many_relationship")
		}

		private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public func post(_ body: Shuttle.BetaTesterBetaGroupsLinkagesRequest) -> Request<Void> {
			Request(method: "POST", url: path, body: body, id: "betaTesters-betaGroups-create_to_many_relationship")
		}

		public func delete(_ body: Shuttle.BetaTesterBetaGroupsLinkagesRequest) -> Request<Void> {
			Request(method: "DELETE", url: path, body: body, id: "betaTesters-betaGroups-delete_to_many_relationship")
		}
	}
}
