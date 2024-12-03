//
//  TopHeadingsCoordinator.swift
//  News
//
//  Created by Darkhan Serkeshev on 30.11.2024.
//

import XCoordinator
import UIKit

enum TopHeadingsRoute: Route {
  case topHeadings
  case alert(
    title: String,
    message: String,
    firstButton: String,
    secondButton: String
  )
  case logOut
}

final class TopHeadingsCoordinator: NavigationCoordinator<TopHeadingsRoute> {
  private var realManager: RealmManagerProtocol
  
  init(realManager: RealmManagerProtocol) {
    self.realManager = realManager
    super.init(initialRoute: .topHeadings)
    
    rootViewController.tabBarItem = UITabBarItem(
      title: "TopHeadings.tabBar.title".localized,
      image: UIImage(named: "news"),
      selectedImage: UIImage(named: "newsSelected")
    )
    rootViewController.tabBarItem.tag = 0
  }
  
  override func prepareTransition(for route: TopHeadingsRoute) -> NavigationTransition {
    switch route {
    case .topHeadings:
      let viewController = TopHeadingsViewController()
      let presenter = TopHeadingsViewPresenter(
        delegate: viewController,
        realmManager: realManager,
        router: unownedRouter
      )
      viewController.presenter = presenter
      return .push(viewController)
    case let .alert(title, message, firstButton, secondButton):
      let alert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert
      )
      alert.addAction(
        UIAlertAction(
          title: firstButton,
          style: .cancel,
          handler: { _ in })
      )
      alert.addAction(
        UIAlertAction(
          title: secondButton,
          style: .destructive,
          handler: { [unowned self] _ in
              self.trigger(.logOut)
          })
      )
      return .present(alert)
    case .logOut:
      return .dismiss()
    }
  }
}
