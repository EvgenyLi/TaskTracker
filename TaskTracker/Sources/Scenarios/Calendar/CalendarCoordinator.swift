//
//  Coordinator.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 21/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import XCoordinator

enum CalendarRoute: Route {
    case initial
}
final class CalendarCoordinator: NavigationCoordinator<CalendarRoute> {
    
    init() {
        super.init(initialRoute: .initial)
    }
    
    override func prepareTransition(for route: CalendarRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let calendarViewController = CalendarViewController()
            return .push(calendarViewController)
        }
    }
}
