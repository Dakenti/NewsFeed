//
//  UIView + Constraints.swift
//  News
//
//  Created by Darkhan Serkeshev on 28.11.2024.
//

import UIKit

extension UIView {
  func anchor(
    top: NSLayoutYAxisAnchor? = nil,
    leading: NSLayoutXAxisAnchor? = nil,
    trailing: NSLayoutXAxisAnchor? = nil,
    bottom: NSLayoutYAxisAnchor? = nil,
    paddingTop: CGFloat = 0,
    paddingLeading: CGFloat = 0,
    paddingTrailing: CGFloat = 0,
    paddingBottom: CGFloat = 0,
    width: CGFloat = 0,
    height: CGFloat = 0
  ){
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(
        equalTo: top,
        constant: paddingTop
      )
      .isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(
        equalTo: bottom,
        constant: -paddingBottom
      )
      .isActive = true
    }
    if let leading = leading {
      leadingAnchor.constraint(
        equalTo: leading,
        constant: paddingLeading
      )
      .isActive = true
    }
    if let trailing = trailing {
      trailingAnchor.constraint(
        equalTo: trailing,
        constant: -paddingTrailing
      )
      .isActive = true
    }
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
}
