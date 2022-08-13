// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder
import Shuttle

extension AppStoreConnect.V1.Profiles.WithID {
	public var bundleID: BundleID {
		BundleID(path: path + "/bundleId")
	}

	public struct BundleID {
		/// Path: `/v1/profiles/{id}/bundleId`
		public let path: String

		public func get(
            bundleIDFields: [ProvisioningAPI.BundleID.Attributes.Field]? = nil
        ) -> Request<BundleIDResponse> {
			Request(
                method: "GET",
                url: path,
                query: makeGetQuery(bundleIDFields),
                id: "profiles-bundleId-get_to_one_related"
            )
		}

		private func makeGetQuery(
            _ bundleIDFields: [ProvisioningAPI.BundleID.Attributes.Field]?
        ) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(bundleIDFields, forKey: "fields[bundleIds]", explode: false)
			return encoder.items
		}
	}
}