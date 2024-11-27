//
//  NetworkManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 25.11.2024.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
  /// Request data from an endpoint
  /// - Parameters:
  ///   - url: the URL
  ///   - httpMethod: The HTTP Method to use, either get or post in this case
  ///   - completion: The completion closure, returning a Result of either the generic type or an error
  func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethods = .get, completion: @escaping (Result<T, Error>) -> Void) {
    let completionOnMain: (Result<T, Error>) -> Void = { result in
      DispatchQueue.main.async {
        completion(result)
      }
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.method
    
    let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completionOnMain(.failure(error))
        return
      }
      
      guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ApiErrors.invalidResponse)) }
      if !(200..<300).contains(urlResponse.statusCode) {
        return completionOnMain(.failure(ApiErrors.invalidStatusCode(urlResponse.statusCode)))
      }
      
      guard let data = data else { return }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      do {
        let users = try decoder.decode(T.self, from: data)
        completionOnMain(.success(users))
      } catch {
        debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
        completionOnMain(.failure(error))
      }
    }
    
    urlSession.resume()
  }
}
