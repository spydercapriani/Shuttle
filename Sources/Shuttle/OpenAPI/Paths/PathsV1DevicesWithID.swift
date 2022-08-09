// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get
import URLQueryEncoder

extension AppStoreConnect.V1.Devices {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/devices/{id}`
		public let path: String

		public func get(fieldsDevices: [FieldsDevices]? = nil) -> Request<Shuttle.DeviceResponse> {
			Request(method: "GET", url: path, query: makeGetQuery(fieldsDevices), id: "devices-get_instance")
		}

		private func makeGetQuery(_ fieldsDevices: [FieldsDevices]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsDevices, forKey: "fields[devices]", explode: false)
			return encoder.items
		}

		public enum FieldsDevices: String, Codable, CaseIterable {
			case addedDate
			case deviceClass
			case model
			case name
			case platform
			case status
			case udid
		}

		public func patch(_ body: Shuttle.DeviceUpdateRequest) -> Request<Shuttle.DeviceResponse> {
			Request(method: "PATCH", url: path, body: body, id: "devices-update_instance")
		}
	}
}
