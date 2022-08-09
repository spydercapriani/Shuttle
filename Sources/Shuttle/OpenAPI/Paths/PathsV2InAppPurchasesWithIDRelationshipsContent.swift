// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V2.InAppPurchases.WithID.Relationships {
	public var content: Content {
		Content(path: path + "/content")
	}

	public struct Content {
		/// Path: `/v2/inAppPurchases/{id}/relationships/content`
		public let path: String
	}
}