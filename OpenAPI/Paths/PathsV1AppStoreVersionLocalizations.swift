// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appStoreVersionLocalizations: AppStoreVersionLocalizations {
		AppStoreVersionLocalizations(path: path + "/appStoreVersionLocalizations")
	}

	public struct AppStoreVersionLocalizations {
		/// Path: `/v1/appStoreVersionLocalizations`
		public let path: String

		public func post(_ body: Shuttle.AppStoreVersionLocalizationCreateRequest) -> Request<Shuttle.AppStoreVersionLocalizationResponse> {
			Request(method: "POST", url: path, body: body, id: "appStoreVersionLocalizations-create_instance")
		}
	}
}