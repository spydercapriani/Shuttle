// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var territories: Territories {
		Territories(path: path + "/territories")
	}

	public struct Territories {
		/// Path: `/v1/territories`
		public let path: String

		public func get(fieldsTerritories: [FieldsTerritories]? = nil, limit: Int? = nil) -> Request<Shuttle.TerritoriesResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsTerritories, limit), id: "territories-get_collection")
		}

		private func makeGetQuery(_ fieldsTerritories: [FieldsTerritories]?, _ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsTerritories, forKey: "fields[territories]", explode: false)
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public enum FieldsTerritories: String, Codable, CaseIterable {
			case currency
		}
	}
}