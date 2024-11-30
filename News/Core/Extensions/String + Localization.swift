//
//  String + Localization.swift
//  News
//
//  Created by Darkhan Serkeshev on 28.11.2024.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(
      self,
      comment: "\(self) Could not be found in Localizable.strings"
    )
  }
}
