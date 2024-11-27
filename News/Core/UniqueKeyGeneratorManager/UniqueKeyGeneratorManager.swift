//
//  UniqueKeyGeneratorManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

import Foundation

struct UniqueKeyGeneratorManager {
  static func generateUniqueEncryptionKey() -> Data? {
    var bytes = [UInt8](repeating: 0, count: 64)
    let result = SecRandomCopyBytes(kSecRandomDefault, 64, &bytes)
    
    guard result == errSecSuccess else {
      return nil
    }
    
    return Data(bytes)
  }
}
