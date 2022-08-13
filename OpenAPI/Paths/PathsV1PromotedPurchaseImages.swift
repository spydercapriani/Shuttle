// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var promotedPurchaseImages: PromotedPurchaseImages {
		PromotedPurchaseImages(path: path + "/promotedPurchaseImages")
	}

	public struct PromotedPurchaseImages {
		/// Path: `/v1/promotedPurchaseImages`
		public let path: String

		public func post(_ body: Shuttle.PromotedPurchaseImageCreateRequest) -> Request<Shuttle.PromotedPurchaseImageResponse> {
			Request(method: "POST", url: path, body: body, id: "promotedPurchaseImages-create_instance")
		}
	}
}