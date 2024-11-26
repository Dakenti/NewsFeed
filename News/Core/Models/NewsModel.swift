//
//  as.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

struct NewsModel: Decodable {
  let totalResults: Int
  var articles: [ArticleModel]
}
