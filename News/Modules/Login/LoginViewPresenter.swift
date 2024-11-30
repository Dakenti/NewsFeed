//
//  LoginViewPresenter.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import Foundation
import XCoordinator

protocol LoginViewPresenterProtocol: AnyObject {
  func checkCredentials(username: String, password: String)
}

final class LoginViewPresenter {
  weak var delegate: LoginViewControllerProtocol?
  
  private let realmManager: RealmManagerProtocol
  private let router: UnownedRouter<MainRoute>
    
  init(
    delegate: LoginViewControllerProtocol,
    realmManager: RealmManagerProtocol,
    router: UnownedRouter<MainRoute>
  ) {
    self.delegate = delegate
    self.realmManager = realmManager
    self.router = router
  }
}

extension LoginViewPresenter: LoginViewPresenterProtocol {
  func checkCredentials(username: String, password: String) {
    let passedCheck = realmManager.checkUserCredentials(username: username, password: password)
    
    if passedCheck {
      router.trigger(.topHeadings)
    } else {
      router.trigger(
        .alert(
          title: "Login.alert.title".localized,
          message: "Login.alert.message".localized,
          buttonTitle: "Login.alert.button".localized
        )
      )
    }
  }
}
