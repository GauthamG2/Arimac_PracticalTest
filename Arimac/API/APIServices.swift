//
//  APIServices.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import Foundation
import Moya

enum APIService {
    case getNews
    case getTopNews
}

extension APIService: TargetType {
    
    var environment: APIEnvironment {
        NetworkManager.environment
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environment.baseURL) else {fatalError("base url not configured")}
        return url
    }
    
    public var path: String {
        switch self {
        case .getNews:
            return "/everything"
        case .getTopNews:
            return "/top-headlines"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        case .getTopNews:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getNews:
            return .requestParameters(parameters: ["q" : "Apple"], encoding: URLEncoding.default)
        case .getTopNews:
            return .requestParameters(parameters: ["country" : "us"], encoding: URLEncoding.default)
        }
    }

    
    public var headers: [String : String]? {
        var params = [ "Accept": "application/json"]
        switch self {
        case .getNews:
            params = ["x-api-key" : "480a176fd05d4073adc5f85e6830378f"]
            return params
        case .getTopNews:
            let params2 = ["x-api-key" : "480a176fd05d4073adc5f85e6830378f"]
            return params2
        }
    }
    
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
