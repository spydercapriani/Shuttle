// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.AppEncryptionDeclarations.WithID.Relationships {
	public var builds: Builds {
		Builds(path: path + "/builds")
	}

	public struct Builds {
		/// Path: `/v1/appEncryptionDeclarations/{id}/relationships/builds`
		public let path: String

		public func post(_ body: Shuttle.AppEncryptionDeclarationBuildsLinkagesRequest) -> Request<Void> {
			Request(method: "POST", url: path, body: body, id: "appEncryptionDeclarations-builds-create_to_many_relationship")
		}
	}
}
