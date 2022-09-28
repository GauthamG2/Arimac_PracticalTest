//
//  NewsData.swift
//  Arimac
//
//  Created by Gautham on 2022-09-29.
//

import Foundation

struct News: Codable {
    var status: String?
    var totalResults: Int?
    public var articles: [Articles]?
    
    public init(articles: [Articles]?) {
        self.articles = articles
    }
}

struct Articles: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
