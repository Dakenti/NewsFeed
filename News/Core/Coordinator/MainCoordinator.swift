//
//  MainCoordinator.swift
//  News
//
//  Created by Darkhan Serkeshev on 29.11.2024.
//

import XCoordinator
import UIKit

enum MainRoute: Route {
  case login
  case alert(title: String, message: String, buttonTitle: String)
  case topHeadings
}

final class MainCoordinator: NavigationCoordinator<MainRoute> {
  var realManager: RealmManagerProtocol
  
  init(realManager: RealmManagerProtocol) {
    self.realManager = realManager
    super.init(initialRoute: .login)
  }
  
  override func prepareTransition(for route: MainRoute) -> NavigationTransition {
    switch route {
    case .login:
      let viewController = LoginViewController()
      let presenter = LoginViewPresenter(
        delegate: viewController,
        realmManager: realManager,
        router: unownedRouter
      )
      viewController.presenter = presenter
      return .push(viewController)
    case let .alert(title, message, buttonTitle):
      let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert
      )
      alert.addAction(
        UIAlertAction(
          title: buttonTitle,
          style: .cancel,
          handler: { _ in })
      )
      return .present(alert)
    case .topHeadings:
      let viewController = TopHeadingsViewController()
      return .push(viewController)
    }
  }
}
