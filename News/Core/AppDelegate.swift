//
//  AppDelegate.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import UIKit
import XCoordinator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  private lazy var mainWindow = UIWindow()
  private let realmManager = RealmManager()
  private lazy var router = MainCoordinator(realManager: realmManager).strongRouter
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    router.setRoot(for: mainWindow)
    handleAppRun()
    
    return true
  }
  
  private func handleAppRun() {
    if isFirstAppStart() {
      generateRealmEncryptionKey()
      realmManager.setupRealm()
    }
  }
  
  private func isFirstAppStart() -> Bool {
    let isFirstAppStart = UserSettingsManager.isFirstStart
    if isFirstAppStart {
      UserSettingsManager.isFirstStart = false
    }
    return isFirstAppStart
  }
  
  private func generateRealmEncryptionKey() {
    let realmEncryptionKey = UniqueKeyGeneratorManager.generateUniqueEncryptionKey()
    if let realmEncryptionKey = realmEncryptionKey {
      KeyChainManager.save(
        key: .realmEncryptionKey,
        data: realmEncryptionKey
      )
    }
  }
}
