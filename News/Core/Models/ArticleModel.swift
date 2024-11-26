//
//  ArticleModel.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

struct ArticleModel: Decodable {
  let source: SourceModel
  let author: String?
  let title: String?
  let description: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String??
}
