// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appStoreVersionPromotions: AppStoreVersionPromotions {
		AppStoreVersionPromotions(path: path + "/appStoreVersionPromotions")
	}

	public struct AppStoreVersionPromotions {
		/// Path: `/v1/appStoreVersionPromotions`
		public let path: String

		public func post(_ body: Shuttle.AppStoreVersionPromotionCreateRequest) -> Request<Shuttle.AppStoreVersionPromotionResponse> {
			Request(method: "POST", url: path, body: body, id: "appStoreVersionPromotions-create_instance")
		}
	}
}
