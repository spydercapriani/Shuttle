// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var betaAppClipInvocationLocalizations: BetaAppClipInvocationLocalizations {
		BetaAppClipInvocationLocalizations(path: path + "/betaAppClipInvocationLocalizations")
	}

	public struct BetaAppClipInvocationLocalizations {
		/// Path: `/v1/betaAppClipInvocationLocalizations`
		public let path: String

		public func post(_ body: Shuttle.BetaAppClipInvocationLocalizationCreateRequest) -> Request<Shuttle.BetaAppClipInvocationLocalizationResponse> {
			Request(method: "POST", url: path, body: body, id: "betaAppClipInvocationLocalizations-create_instance")
		}
	}
}
