// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder
import Shuttle

extension AppStoreConnect.V1.BundleIDCapabilities {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/bundleIdCapabilities/{id}`
		public let path: String

		public func patch(_ body: BundleIDCapabilityUpdateRequest) -> Request<BundleIDCapabilityResponse> {
			Request(
                method: "PATCH",
                url: path,
                body: body,
                id: "bundleIdCapabilities-update_instance"
            )
		}

		public var delete: Request<Void> {
			Request(
                method: "DELETE",
                url: path,
                id: "bundleIdCapabilities-delete_instance"
            )
		}
	}
}
