// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BuildBundles.WithID.Relationships {
	public var buildBundleFileSizes: BuildBundleFileSizes {
		BuildBundleFileSizes(path: path + "/buildBundleFileSizes")
	}

	public struct BuildBundleFileSizes {
		/// Path: `/v1/buildBundles/{id}/relationships/buildBundleFileSizes`
		public let path: String
	}
}
