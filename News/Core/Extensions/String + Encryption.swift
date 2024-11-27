//
//  String + Encryption.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

import Foundation
import CommonCrypto

extension String {
  func sha512() -> Data? {
    let stringData = data(using: String.Encoding.utf8)!
    var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
    _ = result.withUnsafeMutableBytes { resultBytes in
      stringData.withUnsafeBytes { stringBytes in
        CC_SHA512(stringBytes, CC_LONG(stringData.count), resultBytes)
      }
    }
    return result
  }
}
