//
//  HttpMethod.swift
//  News
//
//  Created by Darkhan Serkeshev on 25.11.2024.
//

enum HttpMethods: String {
  case get
  case post
  
  var method: String { rawValue.uppercased() }
}
