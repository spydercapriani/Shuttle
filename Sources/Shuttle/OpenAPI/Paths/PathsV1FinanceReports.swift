// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1 {
	public var financeReports: FinanceReports {
		FinanceReports(path: path + "/financeReports")
	}

	public struct FinanceReports {
		/// Path: `/v1/financeReports`
		public let path: String

		public func get(parameters: GetParameters) -> Request<String> {
			Request(method: "GET", url: path, query: parameters.asQuery, id: "financeReports-get_collection")
		}

		public struct GetParameters {
			public var filterRegionCode: [String]
			public var filterReportDate: [String]
			public var filterReportType: [FilterReportType]
			public var filterVendorNumber: [String]

			public enum FilterReportType: String, Codable, CaseIterable {
				case financial = "FINANCIAL"
				case financeDetail = "FINANCE_DETAIL"
			}

			public init(filterRegionCode: [String], filterReportDate: [String], filterReportType: [FilterReportType], filterVendorNumber: [String]) {
				self.filterRegionCode = filterRegionCode
				self.filterReportDate = filterReportDate
				self.filterReportType = filterReportType
				self.filterVendorNumber = filterVendorNumber
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(filterRegionCode, forKey: "filter[regionCode]")
				encoder.encode(filterReportDate, forKey: "filter[reportDate]")
				encoder.encode(filterReportType, forKey: "filter[reportType]")
				encoder.encode(filterVendorNumber, forKey: "filter[vendorNumber]")
				return encoder.items
			}
		}
	}
}
