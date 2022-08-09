// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BuildBundles.WithID {
	public var buildBundleFileSizes: BuildBundleFileSizes {
		BuildBundleFileSizes(path: path + "/buildBundleFileSizes")
	}

	public struct BuildBundleFileSizes {
		/// Path: `/v1/buildBundles/{id}/buildBundleFileSizes`
		public let path: String

		public func get(fieldsBuildBundleFileSizes: [FieldsBuildBundleFileSizes]? = nil, limit: Int? = nil) -> Request<Shuttle.BuildBundleFileSizesResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsBuildBundleFileSizes, limit), id: "buildBundles-buildBundleFileSizes-get_to_many_related")
		}

		private func makeGetQuery(_ fieldsBuildBundleFileSizes: [FieldsBuildBundleFileSizes]?, _ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsBuildBundleFileSizes, forKey: "fields[buildBundleFileSizes]", explode: false)
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}

		public enum FieldsBuildBundleFileSizes: String, Codable, CaseIterable {
			case deviceModel
			case downloadBytes
			case installBytes
			case osVersion
		}
	}
}
