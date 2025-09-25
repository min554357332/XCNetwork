import Foundation
import Alamofire

public struct NERequestInterceptor: RequestInterceptor {
    
    private let ua: String
    
    public init() async {
        self.ua = await XCNetwork.share.ua_decorator.decrypt_ua
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.setValue(self.ua, forHTTPHeaderField: "User-Agent")
        completion(.success(request))
    }
}
