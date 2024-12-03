//
//  RealmManagerProtocol.swift
//  News
//
//  Created by Darkhan Serkeshev on 29.11.2024.
//

protocol RealmManagerProtocol {
  func setupRealm()
  func checkUserCredentials(username: String, password: String) -> Bool
  func getCurrentLoggedInUsername() -> String?
  func logOut(username: String) throws
}
