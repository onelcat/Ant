//
//  API.swift
//  Ant
//
//  Created by flqy on 2020/12/2.
//

import Foundation
import RxMoya
import RxSwift
import ObjectMapper
import Moya

enum BangBangWo {
    case taskDetails(String?,String)
}

extension BangBangWo: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8888/")!
    }
    
    var path: String {
        return "taskDetails"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

#if DEBUG

let bangbangwoProvider = MoyaProvider<BangBangWo>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                                                             logOptions: .verbose))])
#else

let bangbangwoProvider = MoyaProvider<BangBangWo>(plugins: [])

#endif

struct ResponseHead: Mappable {
    var code: Int = 1000
    var msg: String = "数据解析错误"
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
    }
}

struct ResponseData<T: Mappable>: Mappable {
    var data: T?
    var head: ResponseHead!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        head <- map["head"]
    }
}
