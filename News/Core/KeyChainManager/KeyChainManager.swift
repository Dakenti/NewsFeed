//
//  KeyChainManager.swift
//  News
//
//  Created by Darkhan Serkeshev on 27.11.2024.
//

import Foundation

extension KeyChainManager {
  enum TypeKey: String {
    case realmEncryptionKey
  }
}

final class KeyChainManager {
  
  static func save(key: TypeKey, data: Data) {
    let query: [String: AnyObject] = [
      kSecAttrAccount as String: key.rawValue as AnyObject,
      kSecClass as String: kSecClassGenericPassword,
      kSecValueData as String: data as AnyObject]
    
    SecItemDelete(query as CFDictionary)
    SecItemAdd(query as CFDictionary, nil)
  }
  
  static func remove(key: TypeKey) {
    let query: [String: AnyObject] = [
      kSecAttrAccount as String: key.rawValue as AnyObject,
      kSecClass as String: kSecClassGenericPassword]
    
    SecItemDelete(query as CFDictionary)
  }
  
  static func load(key: TypeKey) -> Data? {
    let query: [String: AnyObject] = [
      kSecAttrAccount as String: key.rawValue as AnyObject,
      kSecClass as String: kSecClassGenericPassword,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecReturnData as String: kCFBooleanTrue]
    
    var itemCopy: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)
    
    return status == noErr ? itemCopy as? Data : nil
  }
}
