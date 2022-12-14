// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appEventLocalizations: AppEventLocalizations {
		AppEventLocalizations(path: path + "/appEventLocalizations")
	}

	public struct AppEventLocalizations {
		/// Path: `/v1/appEventLocalizations`
		public let path: String

		public func post(_ body: Shuttle.AppEventLocalizationCreateRequest) -> Request<Shuttle.AppEventLocalizationResponse> {
			Request(method: "POST", url: path, body: body, id: "appEventLocalizations-create_instance")
		}
	}
}
