import Foundation
import XCCache

public protocol IPConfig: NECache {
    var isp: String { get }
    var ipcountry: String { get }
}

public struct IPConfiguration {
    public static func fire() async throws -> IPConfig {
        return try await withThrowingTaskGroup { group in
            group.addTask {
                try await IPApiRequest.fire()
            }
            group.addTask {
                try await IPInfoRequest.fire()
            }
            for try await result in group {
                group.cancelAll()
                return result
            }
            return Ip_info_response(country: await ReqDefArge.local(), org: await ReqDefArge.local())
        }
    }
}
