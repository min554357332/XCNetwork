import Foundation
import AES_256_CBC

public struct UA_decorator: Sendable {
    private let ua: String
    
    public init(
        ua: String
    ) async throws {
        self.ua = ua
        self.decrypt_ua = try await AES256CBC.de_string_async(ua, -15000)
    }
    
    public let decrypt_ua: String
}
