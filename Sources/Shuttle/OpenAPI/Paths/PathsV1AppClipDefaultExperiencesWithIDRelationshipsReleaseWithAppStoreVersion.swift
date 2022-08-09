// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppClipDefaultExperiences.WithID.Relationships {
	public var releaseWithAppStoreVersion: ReleaseWithAppStoreVersion {
		ReleaseWithAppStoreVersion(path: path + "/releaseWithAppStoreVersion")
	}

	public struct ReleaseWithAppStoreVersion {
		/// Path: `/v1/appClipDefaultExperiences/{id}/relationships/releaseWithAppStoreVersion`
		public let path: String

		public var get: Request<Shuttle.AppClipDefaultExperienceReleaseWithAppStoreVersionLinkageResponse> {
			Request(method: "GET", url: path, id: "appClipDefaultExperiences-releaseWithAppStoreVersion-get_to_one_relationship")
		}

		public func patch(_ body: Shuttle.AppClipDefaultExperienceReleaseWithAppStoreVersionLinkageRequest) -> Request<Void> {
			Request(method: "PATCH", url: path, body: body, id: "appClipDefaultExperiences-releaseWithAppStoreVersion-update_to_one_relationship")
		}
	}
}