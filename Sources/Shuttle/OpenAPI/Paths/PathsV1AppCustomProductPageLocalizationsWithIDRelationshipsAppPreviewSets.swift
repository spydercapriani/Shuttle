// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppCustomProductPageLocalizations.WithID.Relationships {
	public var appPreviewSets: AppPreviewSets {
		AppPreviewSets(path: path + "/appPreviewSets")
	}

	public struct AppPreviewSets {
		/// Path: `/v1/appCustomProductPageLocalizations/{id}/relationships/appPreviewSets`
		public let path: String
	}
}
