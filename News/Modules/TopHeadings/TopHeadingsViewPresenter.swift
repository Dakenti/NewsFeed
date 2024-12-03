//
//  TopHeadingsViewPresenter.swift
//  News
//
//  Created by Darkhan Serkeshev on 30.11.2024.
//

import Foundation
import XCoordinator

protocol TopHeadingsViewPresenterProtocol: AnyObject {
  func getUsername()
  func logOut()
}

final class TopHeadingsViewPresenter {
  weak var delegate: TopHeadingsViewControllerProtocol?
  
  private let realmManager: RealmManagerProtocol
  private let router: UnownedRouter<TopHeadingsRoute>
  private var currentLoggedInUsername: String = ""
  
  init(
    delegate: TopHeadingsViewControllerProtocol,
    realmManager: RealmManagerProtocol,
    router: UnownedRouter<TopHeadingsRoute>
  ) {
    self.delegate = delegate
    self.realmManager = realmManager
    self.router = router
  }
}

extension TopHeadingsViewPresenter: TopHeadingsViewPresenterProtocol {
  func getUsername() {
    if let username = realmManager.getCurrentLoggedInUsername(), let lastLetter = username.last {
      currentLoggedInUsername = username
      delegate?.setProfilePlaceholder(lastLetter.uppercased())
    }
  }
  
  func logOut() {
    do {
      try realmManager.logOut(username: currentLoggedInUsername)
      router.trigger(.logOut)
    } catch {
      print(error)
    }
  }
}
