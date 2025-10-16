import Foundation
import AES_256_CBC

public enum LocalResources {
    case host
    case global_config
    case citys
}

public extension LocalResources {
    func read() async throws -> Data {
        let resource = self.resource
        let string = try String(contentsOf: resource, encoding: .utf8)
        let aaa = try await AES256CBC.de_string_async(string, -150010)
        let aes_result = try await AES256CBC.de_data_async(string, -15000)
        return aes_result
    }
    
    var resource: URL {
        let name = switch self {
        case .host:
            "host"
        case .global_config:
            "global_config"
        case .citys:
            "citys"
        }
        var resource_url = Bundle.main.url(forResource: name, withExtension: nil)
        if resource_url == nil {
            let testBundle = Bundle(identifier: "xcnetwork.XCNetworkTests")
            let resourceURL = testBundle?.resourceURL?.appendingPathComponent("XCNetwork_XCNetworkTests.bundle")
            let testResourceBundle = Bundle(url: resourceURL!)
            resource_url = testResourceBundle!.url(forResource: name, withExtension: nil)
        }
        return resource_url!
    }
}
