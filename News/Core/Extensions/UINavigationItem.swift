//
//  UINavigationItem.swift
//  News
//
//  Created by Darkhan Serkeshev on 02.12.2024.
//

import UIKit

extension UINavigationItem {
  func configureLeftBarItem(
    letter: String
  ) {
    let containerView = UIView()
    containerView.layer.cornerRadius = 15
    containerView.layer.masksToBounds = true
    containerView.layer.borderWidth = 2.0
    containerView.layer.borderColor = UIColor.darkGray.cgColor
    containerView.anchor(width: 30, height: 30)
    
    let label = UILabel()
    label.text = letter
    label.font = UIFont.boldSystemFont(ofSize: 14)
    containerView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
    ])
    
    let barItem = UIBarButtonItem(customView: containerView)
    
    leftBarButtonItem = barItem
  }
  
  func configureRightBarItem(
    iconImage: UIImage?,
    iconTintColor: UIColor = .darkGray,
    target: Any?,
    selector: Selector
  ) {
    let button = UIButton(type: .system)
    let icon = iconImage?.withRenderingMode(.alwaysTemplate)
    button.setImage(icon, for: .normal)
    button.tintColor = .black
    button.addTarget(target, action: selector, for: .touchUpInside)
    
    let barItem = UIBarButtonItem(customView: button)
    barItem.customView?.anchor(width: 30, height: 30)
    
    rightBarButtonItem = barItem
  }
}
