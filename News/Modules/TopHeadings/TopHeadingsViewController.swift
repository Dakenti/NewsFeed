//
//  TopHeadingsViewController.swift
//  News
//
//  Created by Darkhan Serkeshev on 29.11.2024.
//

import UIKit

protocol TopHeadingsViewControllerProtocol: AnyObject {
  func setProfilePlaceholder(_ letter: String)
}

final class TopHeadingsViewController: UIViewController {
  
  var presenter: TopHeadingsViewPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "TopHeadings.navBar.title".localized
    
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

// MARK: - TopHeadingsViewControllerProtocol

extension TopHeadingsViewController: TopHeadingsViewControllerProtocol {
  func setProfilePlaceholder(_ letter: String) {
    navigationItem.configureLeftBarItem(letter: letter)
  }
}
