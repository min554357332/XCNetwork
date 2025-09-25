import Foundation

public struct Node_request: Requestprotocol {
    public init() async throws {}
    
    public var platform: String!
    
    public var datetime: Int!
    
    public var simcountry: String?
    
    public var isp: String?
    
    public var ipcountry: String?
    
    public var country: String!
    
    public var local: String!
    
    public var lang: String!
    
    public var timezone: String!
    
    public var first_install_time: Int!
    
    public var last_update_time: Int!
    
    public var phone_model: String!
    
    public var network_type: String!
    
    public var phone_sdk: String!
    
    public var pk: String!
    
    public var uuid: String!
    
    public var ver: Int!
    
    public var is_vip: Int!
    
    public var is_cn: Bool!
    
    public var city_id: Int = 0
    public var retry: Int = 0
}

public extension Node_request {
    static func fire(_ city_id: Int, retry: Int = 0) async throws -> [Node_response] {
        var paramaters = try await Node_request.create()
        paramaters.city_id = city_id
        paramaters.retry = retry
        let host = try await HostRequest.fire()
        let api = await XCNetwork.share.http_api_decorator.decrypt_node
        let url = host.config_host + api
        let task = NE.fire(url, paramaters: paramaters)
        do {
            let result = try await task.serModel(Base_response<[Node_response]>.self, dataPreprocessor: XCNetwork.share.ne_data_preprocessor).value
            return result.data ?? []
        } catch {
            print(task.cURLDescription())
            throw error
        }
        
    }
}
