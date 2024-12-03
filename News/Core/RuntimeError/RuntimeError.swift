//
//  RuntimeError.swift
//  News
//
//  Created by Darkhan Serkeshev on 03.12.2024.
//

import Foundation

struct RuntimeError: LocalizedError {
  let message: String
  var errorDescription: String? { message }
}
