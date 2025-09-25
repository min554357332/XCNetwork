import Foundation
import Alamofire

public struct Report_request: Requestprotocol {
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
    
    
    public var name: String!
    public var retry: Int = 0
    public var core: String!
    public var agreement: String!
    public var event: String!
    public var duration: Int?
}

public extension Report_request {
    private enum CodingKeys: String, CodingKey {
        case platform,datetime,simcountry,isp,ipcountry,country,local,lang,timezone,first_install_time,last_update_time,phone_model,network_type,phone_sdk,pk,uuid,ver,is_vip,is_cn
        case name,retry,core,event,duration
        case agreement = "protocol"
    }
}

public extension Report_request {
    static func fire(
        name: String,
        retry: Int,
        core: String,
        agreement: String,
        event: String,
        duration: Int? = nil
    ) async throws {
        if event == "disconnect" && duration == nil {
            assertionFailure("当event为disconnect时，duration不能为空")
        }
        var paramaters = try await Report_request.create()
        paramaters.name = name
        paramaters.retry = retry
        paramaters.core = core
        paramaters.agreement = agreement
        paramaters.event = event
        paramaters.duration = duration
        let host = try await HostRequest.fire()
        let api = await XCNetwork.share.http_api_decorator.decrypt_report
        let url = host.config_host + api
        let task = NE.fire(url, method: .post, paramaters: paramaters)
        _ = try await task.serModel(
            Base_response<Empty>.self
        ).value
    }
}
