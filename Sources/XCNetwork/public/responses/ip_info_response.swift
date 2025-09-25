import Foundation

public struct Ip_info_response: IPConfig, Sendable, Codable {
    var country: String
    var org: String
}

public extension Ip_info_response {
    var isp: String {
        self.org
    }
    
    var ipcountry: String {
        self.country
    }
}
