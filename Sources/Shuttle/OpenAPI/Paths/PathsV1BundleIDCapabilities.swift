// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var bundleIDCapabilities: BundleIDCapabilities {
		BundleIDCapabilities(path: path + "/bundleIdCapabilities")
	}

	public struct BundleIDCapabilities {
		/// Path: `/v1/bundleIdCapabilities`
		public let path: String

		public func post(_ body: Shuttle.BundleIDCapabilityCreateRequest) -> Request<Shuttle.BundleIDCapabilityResponse> {
			Request(method: "POST", url: path, body: body, id: "bundleIdCapabilities-create_instance")
		}
	}
}
