//
//  TopHeadingsViewController.swift
//  News
//
//  Created by Darkhan Serkeshev on 29.11.2024.
//

import UIKit

protocol TopHeadingsViewControllerProtocol: AnyObject {}

final class TopHeadingsViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
  }
}

// MARK: - TopHeadingsViewControllerProtocol

extension TopHeadingsViewController: TopHeadingsViewControllerProtocol {
  
}
