import Foundation
import AES_256_CBC

extension String {
    func toData_async(_ err_code: Int32) async throws -> Data {
        return try await withUnsafeThrowingContinuation { c in
            do {
                let result = try self.toData(err_code)
                c.resume(returning: result)
            } catch {
                c.resume(throwing: error)
            }
        }
    }
    func toData(_ err_code: Int32) throws -> Data {
        if let data = Data(base64Encoded: self) {
            return data
        }
        if let data = self.data(using: .utf8) {
            return data
        }
        throw AES256CBCErr.decrypt(.decrypt_faild(err_code))
    }
}
