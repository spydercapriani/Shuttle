// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BetaGroups.WithID.Relationships {
	public var app: App {
		App(path: path + "/app")
	}

	public struct App {
		/// Path: `/v1/betaGroups/{id}/relationships/app`
		public let path: String
	}
}
