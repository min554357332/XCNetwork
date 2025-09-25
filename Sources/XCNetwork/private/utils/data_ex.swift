import Foundation
import AES_256_CBC

extension Data {
    func aes_result_to_string_async(err_code: Int32) async throws -> String {
        return try await withUnsafeThrowingContinuation { c in
            do {
                let result = try self.aes_result_to_string(err_code: err_code)
                c.resume(returning: result)
            } catch {
                c.resume(throwing: error)
            }
        }
    }
    
    func aes_result_to_string(err_code: Int32) throws -> String {
        if let string = String(data: self, encoding: .utf8) {
            return string
        }
        throw AES256CBCErr.decrypt(.decrypt_faild(err_code))
    }
}
