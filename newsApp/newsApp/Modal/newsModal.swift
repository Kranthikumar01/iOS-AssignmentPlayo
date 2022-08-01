//
//  newsModal.swift
//  newsApp
//
//  Created by kranthi.kumar on 31/07/22.
//

import Foundation


class newsModel: NSObject {
    
    var status: String?
    var totalResults: Int?
    var articles: [newsArticles] = [newsArticles]()
    
    init(json : [String:Any]) {
        if let status = json["status"] as? Int {
            self.status = String(status)
        }else if let status = json["status"] as? String {
            self.status = status
        }
        if let totalResults = json["totalResults"] as? Int {
            self.totalResults = totalResults
        }
        if let articles = json["articles"] as? [[String:Any]] {
            for item in articles{
                self.articles.append(newsArticles(json: item))
            }
        }
    }
}

class newsArticles: NSObject{
    var author: String?
    var title: String?
    var newsDescription: String?
    var newsURL: String?
    var imageURL: String?

    
    init(json : [String:Any]) {
        if let author = json["author"] as? String {
            self.author = String(author)
        }
        if let title = json["title"] as? String {
            self.title = String(title)
        }
        if let newsDescription = json["description"] as? String {
            self.newsDescription = String(newsDescription)
        }
        if let newsURL = json["url"] as? String {
            self.newsURL = newsURL
        }
        if let imageURL = json["urlToImage"] as? String {
            self.imageURL = imageURL
        }
    }
}
