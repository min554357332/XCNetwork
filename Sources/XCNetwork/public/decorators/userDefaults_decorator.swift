import Foundation
import AES_256_CBC

public struct UserDefault_decorator: Sendable {
    private let first_install_time: String
    private let last_update_time: String
    
    public init(
        first_install_time: String,
        last_update_time: String
    ) async throws {
        self.first_install_time = first_install_time
        self.last_update_time = last_update_time
        self.decrypt_first_install_time = try await AES256CBC.de_string_async(first_install_time, -8000)
        self.decrypt_last_update_time = try await AES256CBC.de_string_async(last_update_time, -9000)
    }
    
    public let decrypt_first_install_time: String
    public let decrypt_last_update_time: String
}
