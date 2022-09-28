//
//  MainViewModel.swift
//  Arimac
//
//  Created by Gautham on 2022-09-28.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class MainViewModel: NSObject {

    // MARK: - Variables
    
    var newsList = Variable<[Articles]>([])
    var topNewsList = Variable<[TopNewsArticles]>([])
    var filteredData = [Articles]()
    
    let provider: MoyaProvider<APIService>
    var canGoBack: Bool
    var afterCreate: Bool = false
    var afterReset: Bool = false
    
    init(canGoBack: Bool = true,afterReset: Bool = false) {
        self.canGoBack = canGoBack
        if afterReset {
            self.afterReset = afterReset
        }
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<APIService>(plugins: [networkLogger])
    }
    
    // MARK: - API Call
    
    func getNews(completion: @escaping(Bool, Int, String, Int?) -> ()) {
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, "Internet connection appears to be offline.", nil)
            return
        }
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<APIService>(plugins: [networkLogger])
        
        provider.request(.getNews) { result in
            switch result {
            case let .success(response):
                print(response)
                do {
                    
                    let _response = try response.map(News.self)
                    self.newsList.value = _response.articles ?? []
                    completion(true, 200, "Success", nil)
                } catch {
                    completion(false, 400, "We're having trouble connecting to the server, please try again", nil)
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(Error.self) else {
                        return completion(false, 400, "map error", nil)
                    }
                    completion(false, 400, errorResponse.message, nil)
                } catch {
                    completion(false, 400, "map error", nil)
                }
            }
        }
    }
    
    func getTopNews(completion: @escaping(Bool, Int, String, Int?) -> ()) {
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, "Internet connection appears to be offline.", nil)
            return
        }
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<APIService>(plugins: [networkLogger])
        
        provider.request(.getTopNews) { result in
            switch result {
            case let .success(response):
                print(response)
                do {
                    
                    let _response = try response.map(TopNews.self)
                    self.topNewsList.value = _response.articles ?? []
                    completion(true, 200, "Success", nil)
                } catch {
                    completion(false, 400, "We're having trouble connecting to the server, please try again", nil)
                }
            case let .failure(error):
                do {
                    guard let errorResponse = try error.response?.map(Error.self) else {
                        return completion(false, 400, "map error", nil)
                    }
                    completion(false, 400, errorResponse.message, nil)
                } catch {
                    completion(false, 400, "map error", nil)
                }
            }
        }
    }
}
