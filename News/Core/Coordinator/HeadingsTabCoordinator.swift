//
//  TabsCoordinator.swift
//  News
//
//  Created by Darkhan Serkeshev on 30.11.2024.
//

import UIKit
import XCoordinator

enum HeadingsTabRoute: Route {
  case topHeadings
  case savedHeadings
}

class HeadingsTabCoordinator: TabBarCoordinator<HeadingsTabRoute> {
  private var realManager: RealmManagerProtocol
  private let topHeadingsRouter: StrongRouter<TopHeadingsRoute>
  private let savedHeadingsRouter: StrongRouter<SavedHeadingsRoute>
  
  init(realManager: RealmManagerProtocol) {
    self.realManager = realManager
    
    self.topHeadingsRouter = TopHeadingsCoordinator(realManager: realManager).strongRouter
    self.savedHeadingsRouter = SavedHeadingsCoordinator(realManager: realManager).strongRouter
    
    super.init(
      tabs: [
        topHeadingsRouter,
        savedHeadingsRouter
      ],
      select: topHeadingsRouter
    )
  }
  
  override func prepareTransition(for route: HeadingsTabRoute) -> TabBarTransition {
    switch route {
    case .topHeadings:
      return .select(topHeadingsRouter)
    case .savedHeadings:
      return .select(savedHeadingsRouter)
    }
  }
}
