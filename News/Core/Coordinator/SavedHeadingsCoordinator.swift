//
//  SavedHeadingsCoordinator.swift
//  News
//
//  Created by Darkhan Serkeshev on 01.12.2024.
//

import XCoordinator
import UIKit

enum SavedHeadingsRoute: Route {
  case topHeadings
  case alert(
    title: String,
    message: String,
    firstButton: String,
    secondButton: String
  )
  case logOut
}

final class SavedHeadingsCoordinator: NavigationCoordinator<SavedHeadingsRoute> {
  private var realManager: RealmManagerProtocol
  
  init(realManager: RealmManagerProtocol) {
    self.realManager = realManager
    super.init(initialRoute: .topHeadings)
    
    rootViewController.tabBarItem = UITabBarItem(
      title: "SavedHeadings.tabBar.title".localized,
      image: UIImage(named: "bookmark"),
      selectedImage: UIImage(named: "bookmarkSelected")
    )
    rootViewController.tabBarItem.tag = 1
  }
  
  override func prepareTransition(for route: SavedHeadingsRoute) -> NavigationTransition {
    switch route {
    case .topHeadings:
      let viewController = SavedHeadingsViewController()
      let presenter = SavedHeadingsViewPresenter(
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
