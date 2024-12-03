//
//  User.swift
//  News
//
//  Created by Darkhan Serkeshev on 25.11.2024.
//

import Foundation
import RealmSwift

final class UserModel: Object {
  @Persisted(primaryKey: true) var username = ""
  @Persisted var password = ""
  @Persisted var isLoggedIn = false
  @Persisted var savedArticles: List<ArticleModel>
  
  convenience init(username: String, password: String) {
    self.init()
    self.username = username
    self.password = password
  }
}
