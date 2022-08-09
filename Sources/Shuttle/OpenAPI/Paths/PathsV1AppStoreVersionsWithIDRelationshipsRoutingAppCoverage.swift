// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppStoreVersions.WithID.Relationships {
	public var routingAppCoverage: RoutingAppCoverage {
		RoutingAppCoverage(path: path + "/routingAppCoverage")
	}

	public struct RoutingAppCoverage {
		/// Path: `/v1/appStoreVersions/{id}/relationships/routingAppCoverage`
		public let path: String
	}
}
