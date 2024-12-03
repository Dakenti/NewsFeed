//
//  SavedHeadingsViewPresenter.swift
//  News
//
//  Created by Darkhan Serkeshev on 01.12.2024.
//

import Foundation
import XCoordinator

protocol SavedHeadingsViewPresenterProtocol: AnyObject {
  func getUsername()
  func logOut()
}

final class SavedHeadingsViewPresenter {
  weak var delegate: SavedHeadingsViewControllerProtocol?
  
  private let realmManager: RealmManagerProtocol
  private let router: UnownedRouter<SavedHeadingsRoute>
  private var currentLoggedInUsername: String = ""
  
  init(
    delegate: SavedHeadingsViewControllerProtocol,
    realmManager: RealmManagerProtocol,
    router: UnownedRouter<SavedHeadingsRoute>
  ) {
    self.delegate = delegate
    self.realmManager = realmManager
    self.router = router
  }
}

extension SavedHeadingsViewPresenter: SavedHeadingsViewPresenterProtocol {
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
