//
//  UserSettingsManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

struct UserSettingsManager {
  @UserDefault("isFirstStart", defaultValue: true)
  static var isFirstStart: Bool
}
