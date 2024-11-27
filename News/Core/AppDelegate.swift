//
//  AppDelegate.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let viewController = LoginViewController()
    viewController.view.backgroundColor = .cyan
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    
    handleAppRun()
    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
  }
  
  private func handleAppRun() {
    if isFirstAppStart() {
      generateRealmEncryptionKey()
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
