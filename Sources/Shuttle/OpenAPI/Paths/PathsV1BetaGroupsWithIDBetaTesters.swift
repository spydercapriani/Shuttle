// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BetaGroups.WithID {
	public var betaTesters: BetaTesters {
		BetaTesters(path: path + "/betaTesters")
	}

	public struct BetaTesters {
		/// Path: `/v1/betaGroups/{id}/betaTesters`
		public let path: String

		public func get(fieldsBetaTesters: [FieldsBetaTesters]? = nil, limit: Int? = nil) -> Request<Shuttle.BetaTestersResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsBetaTesters, limit), id: "betaGroups-betaTesters-get_to_many_related")
		}

		private func makeGetQuery(_ fieldsBetaTesters: [FieldsBetaTesters]?, _ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsBetaTesters, forKey: "fields[betaTesters]", explode: false)
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public enum FieldsBetaTesters: String, Codable, CaseIterable {
			case apps
			case betaGroups
			case builds
			case email
			case firstName
			case inviteType
			case lastName
		}
	}
}
