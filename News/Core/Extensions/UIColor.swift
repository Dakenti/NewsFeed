//
//  UIColor.swift
//  News
//
//  Created by Darkhan Serkeshev on 28.11.2024.
//

import UIKit

extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
  }
}
