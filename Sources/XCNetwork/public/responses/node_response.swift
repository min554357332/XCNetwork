import Foundation
import XCCache

public struct Node_response: Sendable, Codable, NECache {
    public var version: Int
    public var core: String
    public var name: String
    public var agreement: String
    public var proxy: String
    public var host: String
    public var localdns: Bool?
}

public extension Node_response {
    private enum CodingKeys: String, CodingKey {
        case version,core,name,proxy,host,localdns
        case agreement = "protocol"
    }
}
