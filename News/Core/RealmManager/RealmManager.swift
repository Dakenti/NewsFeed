//
//  RealmManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

import Foundation
import RealmSwift

final class RealmManager {
  static let shared = RealmManager()
  
  var encryptedRealm: Realm {
    let encryptionKey = KeyChainManager.load(key: .realmEncryptionKey)
    let configurationMain = Realm.Configuration(
      fileURL: inLibrarayFolder(fileName: "main.realm"),
      encryptionKey: encryptionKey
    )
    return try! Realm(configuration: configurationMain)
  }
  
  private var bundledRealmFileUrl: URL? {
    return Bundle.main.url(
      forResource: "bundle",
      withExtension: "realm"
    )
  }
  
  private init() {
    setupRealm()
  }
  
  private func setupRealm() {
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
