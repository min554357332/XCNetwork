import Foundation
import Alamofire
import AES_256_CBC

public struct NEDataPreprocessor: DataPreprocessor {
    private let key: Data
    private let iv: Data
    
    public init() async {
        let decorator = await XCNetwork.share.en_de_decorator!
        self.key = decorator.key_data
        self.iv = decorator.iv_data
    }
    
    public func preprocess(_ data: Data) throws -> Data {
        guard let content = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else { return data }
        do {
            let result = try AES256CBC.decrypt(
                data: try content.toData(11000),
                key: self.key,
                iv: self.iv
            )
            if result.count == data.count { return data }
            return result
        } catch {
            throw error
        }
    }
}
