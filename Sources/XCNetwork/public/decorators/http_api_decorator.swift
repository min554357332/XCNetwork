import Foundation
import AES_256_CBC

public struct HttpApi_decorator: Sendable {
    private let host:           String
    private let citys:          String
    private let global_config:  String
    private let node:           String
    private let report:         String
    
    public init(
        host: String,
        citys: String,
        global_config: String,
        node: String,
        report: String
    ) async throws {
        self.host = host
        self.citys = citys
        self.global_config = global_config
        self.node = node
        self.report = report
        
        self.decrypt_host = try await AES256CBC.de_string_async(host, -3000)
        self.decrypt_citys = try await AES256CBC.de_string_async(citys, -4000)
        self.decrypt_global_config = try await AES256CBC.de_string_async(global_config, -5000)
        self.decrypt_node = try await AES256CBC.de_string_async(node, -6000)
        self.decrypt_report = try await AES256CBC.de_string_async(report, -7000)
    }
    
    public let decrypt_host: String
    public let decrypt_citys: String
    public let decrypt_global_config: String
    public let decrypt_node: String
    public let decrypt_report: String
}


