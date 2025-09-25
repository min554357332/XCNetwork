import Foundation
import AES_256_CBC

public struct Ipconfig_decorator: Sendable {
    private let url_1: String
    private let url_2: String
    private let url_3: String
    
    public init(
        url_1: String,
        url_2: String,
        url_3: String
    ) async throws {
        self.url_1 = url_1
        self.url_2 = url_2
        self.url_3 = url_3
        
        self.decrypt_url_1 = try await AES256CBC.de_string_async(url_1, -12000)
        self.decrypt_url_2 = try await AES256CBC.de_string_async(url_2, -13000)
        self.decrypt_url_3 = try await AES256CBC.de_string_async(url_3, -14000)
    }
    
    public let decrypt_url_1: String
    public let decrypt_url_2: String
    public let decrypt_url_3: String
}
