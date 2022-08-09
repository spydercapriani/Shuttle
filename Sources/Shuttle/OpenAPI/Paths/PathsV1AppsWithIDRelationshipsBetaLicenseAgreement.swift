// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Apps.WithID.Relationships {
	public var betaLicenseAgreement: BetaLicenseAgreement {
		BetaLicenseAgreement(path: path + "/betaLicenseAgreement")
	}

	public struct BetaLicenseAgreement {
		/// Path: `/v1/apps/{id}/relationships/betaLicenseAgreement`
		public let path: String
	}
}
