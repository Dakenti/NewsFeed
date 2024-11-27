//
//  SourceModel.swift
//  News
//
//  Created by Darkhan Serkeshev on 26.11.2024.
//

import RealmSwift

final class SourceModel: Object, Decodable {
  @Persisted var id: String?
  @Persisted var name: String?
}
