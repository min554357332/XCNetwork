import Foundation

public struct Ip_api_response: IPConfig, Sendable, Codable {
    var asn: String
    var org: String
    var country_code: String
}

public extension Ip_api_response {
    var isp: String {
        self.asn + self.org
    }
    
    var ipcountry: String {
        self.country_code
    }
}
