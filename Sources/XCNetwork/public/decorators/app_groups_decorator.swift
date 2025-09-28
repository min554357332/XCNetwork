import Foundation
import AES_256_CBC
import XCNetwork

public actor App_groups_decorator: Sendable {
    private let id: String

    public init(
        id: String
    ) async throws {
        self.id = id
        self.decrypt_id = try await AES256CBC.de_string_async(id, -15000)
    }

    public let decrypt_id: String
}

extension App_groups_decorator {
    public func directory() async throws -> URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.decrypt_id) else {
            throw NSError(domain: "app groups err", code: -1)
        }
        return url
    }
}

extension App_groups_decorator {
    public func fileURL(_ name: String) async throws -> URL {
        try await self.directory().appendingPathComponent(name)
    }
}

extension App_groups_decorator {
    public func chose_city(_ city: Citys_response) async throws {
        let url = try await fileURL("chose_city")
        let data = try JSONEncoder().encode(city)
        let cache_en = await XCNetwork.share.cache_encrypt_data_preprocessor
        let aes_data = try await cache_en!.preprocess(data: data)
        try aes_data.write(to: url)
    }

    public func get_chose_city() async throws -> Citys_response? {
        let url = try await fileURL("chose_city")
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let cache_de = await XCNetwork.share.cache_decrypt_data_preprocessor
        let aes_data = try await cache_de!.preprocess(data: data)
        let city = try JSONDecoder().decode(Citys_response.self, from: aes_data)
        return city
    }
}

extension App_groups_decorator {
    public func chose_node(_ node: Node_response) async throws {
        let url = try await fileURL("chose_node")
        let data = try JSONEncoder().encode(node)
        let cache_en = await XCNetwork.share.cache_encrypt_data_preprocessor
        let aes_data = try await cache_en!.preprocess(data: data)
        try aes_data.write(to: url)
    }

    public func get_chose_node() async throws -> Node_response? {
        let url = try await fileURL("chose_node")
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let cache_de = await XCNetwork.share.cache_decrypt_data_preprocessor
        let aes_data = try await cache_de!.preprocess(data: data)
        let node = try JSONDecoder().decode(Node_response.self, from: aes_data)
        return node
    }
}
