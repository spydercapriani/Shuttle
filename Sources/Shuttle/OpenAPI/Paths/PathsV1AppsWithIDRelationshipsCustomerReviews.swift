// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Apps.WithID.Relationships {
	public var customerReviews: CustomerReviews {
		CustomerReviews(path: path + "/customerReviews")
	}

	public struct CustomerReviews {
		/// Path: `/v1/apps/{id}/relationships/customerReviews`
		public let path: String
	}
}
