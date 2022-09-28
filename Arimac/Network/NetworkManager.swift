//
//  NetworkManager.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    
    var baseURL: String {
        switch NetworkManager.environment {
        case .staging:
            return Config.API.STAGING.HOST
        }
    }
}

struct NetworkManager {
    static let environment: APIEnvironment = .staging
}
