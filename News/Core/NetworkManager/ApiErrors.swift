//
//  ApiErrors.swift
//  News
//
//  Created by Darkhan Serkeshev on 25.11.2024.
//

enum ApiErrors: Error {
  case invalidResponse
  case invalidStatusCode(Int)
}
