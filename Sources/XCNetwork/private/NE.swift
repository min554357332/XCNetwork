import Foundation
import Alamofire

struct NE {
    static func fire<Parameters: Encodable & Sendable>(
        _ c: any URLConvertible,
        method: HTTPMethod = .get,
        paramaters: Parameters? = nil,
        encoder: any ParameterEncoder = URLEncodedFormParameterEncoder.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> DataRequest {
        return AF.request(
            c,
            method: method,
            parameters: paramaters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor) { request in
                try requestModifier?(&request)
                try NE._requestModifier(request: &request)
            }
    }
    
    static func fire(
        _ c: any URLConvertible,
        method: HTTPMethod = .get,
        encoding: any ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        requestModifier: Session.RequestModifier? = nil
    ) -> DataRequest {
        return AF.request(
            c,
            method: method,
            parameters: nil,
            encoding: encoding,
            headers: headers,
            interceptor: interceptor
        ) { request in
            try requestModifier?(&request)
            try NE._requestModifier(request: &request)
        }
    }
    
    static private func _requestModifier(request: inout URLRequest) throws {
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10
    }
    
}

extension DataRequest {
    public func serModel<V: Decodable>(
        _ type: V.Type = V.self,
        autoCancel: Bool = true,
        dataPreprocessor: DataPreprocessor? = nil,
        decoder: any DataDecoder = JSONDecoder(),
        emptyResCodes: Set<Int> = DecodableResponseSerializer<V>.defaultEmptyResponseCodes,
        emptyReqMethods: Set<HTTPMethod> = DecodableResponseSerializer<V>.defaultEmptyRequestMethods
    ) -> DataTask<V> {
        let ser = DecodableResponseSerializer<V>(
            dataPreprocessor: dataPreprocessor ?? DecodableResponseSerializer<V>.defaultDataPreprocessor,
            decoder: decoder,
            emptyResponseCodes: emptyResCodes,
            emptyRequestMethods: emptyReqMethods
        )
        return serializingResponse(
            using: ser,
            automaticallyCancelling: autoCancel
        )
    }
}
