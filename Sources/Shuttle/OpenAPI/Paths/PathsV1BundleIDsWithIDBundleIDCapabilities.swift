// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BundleIDs.WithID {
	public var bundleIDCapabilities: BundleIDCapabilities {
		BundleIDCapabilities(path: path + "/bundleIdCapabilities")
	}

	public struct BundleIDCapabilities {
		/// Path: `/v1/bundleIds/{id}/bundleIdCapabilities`
		public let path: String

		public func get(fieldsBundleIDCapabilities: [FieldsBundleIDCapabilities]? = nil, limit: Int? = nil) -> Request<Shuttle.BundleIDCapabilitiesResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsBundleIDCapabilities, limit), id: "bundleIds-bundleIdCapabilities-get_to_many_related")
		}

		private func makeGetQuery(_ fieldsBundleIDCapabilities: [FieldsBundleIDCapabilities]?, _ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsBundleIDCapabilities, forKey: "fields[bundleIdCapabilities]", explode: false)
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public enum FieldsBundleIDCapabilities: String, Codable, CaseIterable {
			case bundleID = "bundleId"
			case capabilityType
			case settings
		}
	}
}