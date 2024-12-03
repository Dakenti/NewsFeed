//
//  SavedHeadingsViewController.swift
//  News
//
//  Created by Darkhan Serkeshev on 01.12.2024.
//

import UIKit

protocol SavedHeadingsViewControllerProtocol: AnyObject {
  func setProfilePlaceholder(_ letter: String)
}

final class SavedHeadingsViewController: UIViewController {
  
  var presenter: SavedHeadingsViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "SavedHeadings.navBar.title".localized
    
    presenter.getUsername()
    
    navigationItem.configureRightBarItem(
      iconImage: UIImage(named: "logOut"),
      target: self,
      selector: #selector(logOut)
    )
  }
  
  @objc
  private func logOut() {
    presenter.logOut()
  }
}

// MARK: - SavedHeadingsViewControllerProtocol

extension SavedHeadingsViewController: SavedHeadingsViewControllerProtocol {
  func setProfilePlaceholder(_ letter: String) {
    navigationItem.configureLeftBarItem(letter: letter)
  }
}
