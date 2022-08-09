// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var appClipAdvancedExperienceImages: AppClipAdvancedExperienceImages {
		AppClipAdvancedExperienceImages(path: path + "/appClipAdvancedExperienceImages")
	}

	public struct AppClipAdvancedExperienceImages {
		/// Path: `/v1/appClipAdvancedExperienceImages`
		public let path: String

		public func post(_ body: Shuttle.AppClipAdvancedExperienceImageCreateRequest) -> Request<Shuttle.AppClipAdvancedExperienceImageResponse> {
			Request(method: "POST", url: path, body: body, id: "appClipAdvancedExperienceImages-create_instance")
		}
	}
}