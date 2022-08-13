// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder
import Shuttle

extension AppStoreConnect.V1.BundleIDs.WithID {
	public var bundleIDCapabilities: BundleIDCapabilities {
		BundleIDCapabilities(path: path + "/bundleIdCapabilities")
	}

	public struct BundleIDCapabilities {
		/// Path: `/v1/bundleIds/{id}/bundleIdCapabilities`
		public let path: String

		public func get(
            bundleIDCapabilityFields: [BundleIDCapability.Attributes.Field]? = nil,
            limit: Int? = nil
        ) -> Request<BundleIDCapabilitiesResponse> {
			Request(
                method: "GET",
                url: path,
                query: makeGetQuery(bundleIDCapabilityFields, limit),
                id: "bundleIds-bundleIdCapabilities-get_to_many_related"
            )
		}

		private func makeGetQuery(
            _ bundleIDCapabilityFields: [BundleIDCapability.Attributes.Field]?,
            _ limit: Int?
        ) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(bundleIDCapabilityFields, forKey: "fields[bundleIdCapabilities]", explode: false)
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}
	}
}
