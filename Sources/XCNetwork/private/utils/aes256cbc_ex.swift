import Foundation
import AES_256_CBC



extension AES256CBC {
    static func de_string_async(
        _ content: String,
        _ err_code: Int32
    ) async throws -> String {
        let result = try await AES256CBC.de_data_async(content, err_code)
        return try await result.aes_result_to_string_async(err_code: err_code - 1)
    }
    
    static func de_data_async(
        _ content: String,
        _ err_code: Int32
    ) async throws -> Data {
        let data = try await content
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .toData_async(err_code)
        let key = await XCNetwork.share.en_de_decorator.key_data
        let iv = await XCNetwork.share.en_de_decorator.iv_data
        let result = try await AES256CBC.decrypt_async(data: data, key: key, iv: iv)
        return result
    }
}

