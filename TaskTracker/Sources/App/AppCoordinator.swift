//
//  AppCoordinator.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 20/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case test
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    // MARK: - Public
    init() {
        super.init(initialRoute: .test)
    }
    
    // MARK: - Overrides
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        
        switch route {
        case .test:
            let mainCoordinator = MainCoordinator()
            return .present(mainCoordinator)
        }
    }
    
    // MARK: - Private
    private weak var main: MainCoordinator?
}
