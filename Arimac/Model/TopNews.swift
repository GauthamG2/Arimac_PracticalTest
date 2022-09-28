//
//  TopNews.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import Foundation

import Foundation

struct TopNews: Codable {
    var status: String?
    var totalResults: Int?
    public var articles: [TopNewsArticles]?
    
    public init(articles: [TopNewsArticles]?) {
        self.articles = articles
    }
}

struct TopNewsArticles: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
