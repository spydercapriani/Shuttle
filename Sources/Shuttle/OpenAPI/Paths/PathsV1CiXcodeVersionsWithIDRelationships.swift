// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.CiXcodeVersions.WithID {
	public var relationships: Relationships {
		Relationships(path: path + "/relationships")
	}

	public struct Relationships {
		/// Path: `/v1/ciXcodeVersions/{id}/relationships`
		public let path: String
	}
}
