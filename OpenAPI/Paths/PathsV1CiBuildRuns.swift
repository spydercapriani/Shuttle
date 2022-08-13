// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var ciBuildRuns: CiBuildRuns {
		CiBuildRuns(path: path + "/ciBuildRuns")
	}

	public struct CiBuildRuns {
		/// Path: `/v1/ciBuildRuns`
		public let path: String

		public func post(_ body: Shuttle.CiBuildRunCreateRequest) -> Request<Shuttle.CiBuildRunResponse> {
			Request(method: "POST", url: path, body: body, id: "ciBuildRuns-create_instance")
		}
	}
}