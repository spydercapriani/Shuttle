// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.BuildBundles.WithID.Relationships {
	public var betaAppClipInvocations: BetaAppClipInvocations {
		BetaAppClipInvocations(path: path + "/betaAppClipInvocations")
	}

	public struct BetaAppClipInvocations {
		/// Path: `/v1/buildBundles/{id}/relationships/betaAppClipInvocations`
		public let path: String
	}
}
