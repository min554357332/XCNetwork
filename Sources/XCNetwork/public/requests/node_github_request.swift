import Foundation

/*
 https://raw.githubusercontent.com/zhongyat/hh/refs/heads/main/node.txt
 https://raw.githubusercontent.com/zhongyat/hh/refs/heads/main/node_{country}.txt
 */

public struct Node_github_request {
    static func fire(_ countryCode: String?) async throws -> [Node_response] {
        let url = if let code = countryCode {
            "https://raw.githubusercontent.com/zhongyat/hh/refs/heads/main/node_\(code.lowercased()).txt"
        } else {
            "https://raw.githubusercontent.com/zhongyat/hh/refs/heads/main/node.txt"
        }
        let task = NE.fire(url)
        do {
            let result = try await task.serModel(Base_response<[Node_response]>.self, dataPreprocessor: XCNetwork.share.ne_data_preprocessor).value
            return result.data ?? []
        } catch {
            print(task.cURLDescription())
            throw error
        }
    }
}
