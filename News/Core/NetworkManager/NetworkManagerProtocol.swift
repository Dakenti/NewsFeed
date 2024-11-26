//
//  NetworkManagerProtocol.swift
//  News
//
//  Created by Darkhan Serkeshev on 25.11.2024.
//

import Foundation

protocol NetworkManagerProtocol {
  func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethods, completion: @escaping (Result<T, Error>) -> Void)
}
