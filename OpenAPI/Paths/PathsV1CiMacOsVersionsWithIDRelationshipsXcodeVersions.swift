// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.CiMacOsVersions.WithID.Relationships {
	public var xcodeVersions: XcodeVersions {
		XcodeVersions(path: path + "/xcodeVersions")
	}

	public struct XcodeVersions {
		/// Path: `/v1/ciMacOsVersions/{id}/relationships/xcodeVersions`
		public let path: String
	}
}