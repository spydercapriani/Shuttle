// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appCustomProductPages: AppCustomProductPages {
		AppCustomProductPages(path: path + "/appCustomProductPages")
	}

	public struct AppCustomProductPages {
		/// Path: `/v1/appCustomProductPages`
		public let path: String

		public func post(_ body: Shuttle.AppCustomProductPageCreateRequest) -> Request<Shuttle.AppCustomProductPageResponse> {
			Request(method: "POST", url: path, body: body, id: "appCustomProductPages-create_instance")
		}
	}
}
