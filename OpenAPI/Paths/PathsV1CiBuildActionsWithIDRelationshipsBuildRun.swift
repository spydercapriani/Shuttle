// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.CiBuildActions.WithID.Relationships {
	public var buildRun: BuildRun {
		BuildRun(path: path + "/buildRun")
	}

	public struct BuildRun {
		/// Path: `/v1/ciBuildActions/{id}/relationships/buildRun`
		public let path: String
	}
}