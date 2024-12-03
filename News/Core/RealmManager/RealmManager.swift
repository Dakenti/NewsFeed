//
//  RealmManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

import Foundation
import RealmSwift

final public class RealmManager {
  private let bundledRealmFileUrl: URL? = Bundle.main.url(
      forResource: "bundle",
      withExtension: "realm"
    )
}

// MARK: - Public Methods

extension RealmManager: RealmManagerProtocol {
  public func setupRealm() {
    let bundledRealm = getBundledRealm()
    
    var users = [UserModel]()
    for bundledObject in bundledRealm.objects(UserModel.self){
      users.append(bundledObject)
    }
    
    guard users.count > 0 else { return }
    try! encryptedRealm.write {
      for user in users {
        encryptedRealm.create(UserModel.self, value: user)
      }
    }
    
    deleteBundledRealm()
  }
  
  func checkUserCredentials(
    username: String,
    password: String
  ) -> Bool {
    if let user = encryptedRealm.object(ofType: UserModel.self, forPrimaryKey: username), user.password == password {
      try! encryptedRealm.write {
        user.isLoggedIn = true
      }
      return true
    } else {
      return false
    }
  }
  
  func getCurrentLoggedInUsername() -> String? {
    let users = encryptedRealm.objects(UserModel.self)
    for user in users {
      if user.isLoggedIn {
        return user.username
      }
    }
    
    return nil
  }
  
  func logOut(username: String) throws {
    if let user = encryptedRealm.object(ofType: UserModel.self, forPrimaryKey: username) {
      try! encryptedRealm.write {
        user.isLoggedIn = false
      }
    } else {
      throw RuntimeError(message: "Could not log out!")
    }
  }
}

// MARK: - Private Methods

extension RealmManager {
  private var encryptedRealm: Realm {
    let encryptionKey = KeyChainManager.load(key: .realmEncryptionKey)
    let configurationMain = Realm.Configuration(
      fileURL: inLibrarayFolder(fileName: "main.realm"),
      encryptionKey: encryptionKey
    )
    return try! Realm(configuration: configurationMain)
  }
  
  private func getBundledRealm() -> Realm {
    let bundleRealmKey = "password"
    let configurationBundle = Realm.Configuration(
      fileURL: bundledRealmFileUrl,
      encryptionKey: bundleRealmKey.sha512()
    )
    return try! Realm(configuration: configurationBundle)
  }
  
  private func deleteBundledRealm() {
    do {
      try FileManager.default.removeItem(
        atPath: bundledRealmFileUrl?.absoluteString ?? ""
      )
    } catch {
      print("Could not delete bundle.realm, because \(error.localizedDescription)")
    }
  }
  
  private func inLibrarayFolder(fileName: String) -> URL {
    return URL(
      fileURLWithPath: NSSearchPathForDirectoriesInDomains(
        .libraryDirectory,
        .userDomainMask,
        true
      )[0],
      isDirectory: true
    )
    .appendingPathComponent(fileName)
  }
}
