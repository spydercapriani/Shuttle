// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Apps.WithID.Relationships {
	public var appClips: AppClips {
		AppClips(path: path + "/appClips")
	}

	public struct AppClips {
		/// Path: `/v1/apps/{id}/relationships/appClips`
		public let path: String
	}
}