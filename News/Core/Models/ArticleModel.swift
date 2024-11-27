//
//  ArticleModel.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import RealmSwift
import Foundation

final class ArticleModel: Object, Decodable {
  @Persisted var source: SourceModel?
  @Persisted var author: String?
  @Persisted(primaryKey: true) var title: String?
  @Persisted var shortDescription: String?
  @Persisted var urlToImage: String?
  @Persisted var publishedAt: Date?
  @Persisted var content: String?
  
  @Persisted var user: UserModel?
  
  enum CodingKeys: String, CodingKey {
    case source, author, title, urlToImage, publishedAt, content
    case shortDescription = "description"
  }
  
  convenience required init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    source = try container.decodeIfPresent(SourceModel.self, forKey: .source)
    author = try container.decodeIfPresent(String.self, forKey: .author)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
    urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
    publishedAt = try container.decodeIfPresent(Date.self, forKey: .publishedAt)
    content = try container.decodeIfPresent(String.self, forKey: .content)
  }
}
