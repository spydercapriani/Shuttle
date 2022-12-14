// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appCustomProductPageLocalizations: AppCustomProductPageLocalizations {
		AppCustomProductPageLocalizations(path: path + "/appCustomProductPageLocalizations")
	}

	public struct AppCustomProductPageLocalizations {
		/// Path: `/v1/appCustomProductPageLocalizations`
		public let path: String

		public func post(_ body: Shuttle.AppCustomProductPageLocalizationCreateRequest) -> Request<Shuttle.AppCustomProductPageLocalizationResponse> {
			Request(method: "POST", url: path, body: body, id: "appCustomProductPageLocalizations-create_instance")
		}
	}
}
