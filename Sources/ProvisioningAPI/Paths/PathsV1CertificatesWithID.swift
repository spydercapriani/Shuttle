// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder
import Shuttle

extension AppStoreConnect.V1.Certificates {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/certificates/{id}`
		public let path: String

		public func get(
            certificateFields: [Certificate.Attributes.Field]? = nil
        ) -> Request<CertificateResponse> {
			Request(
                method: "GET",
                url: path,
                query: makeGetQuery(certificateFields),
                id: "certificates-get_instance"
            )
		}

		private func makeGetQuery(
            _ certificateFields: [Certificate.Attributes.Field]?
        ) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(certificateFields, forKey: "fields[certificates]", explode: false)
			return encoder.items
		}

		public var delete: Request<Void> {
			Request(
                method: "DELETE",
                url: path,
                id: "certificates-delete_instance"
            )
		}
	}
}
