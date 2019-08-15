//
//  MainCoordinator.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 20/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import XCoordinator

enum MainRoute: Route {
    case calendar
    case taskCounter
}

final class MainCoordinator: TabBarCoordinator<MainRoute> {
    
    // MARK: - Stored properties
    private let calendarRouter: AnyRouter<CalendarRoute>
    private let taskCounterRouter: AnyRouter<TaskCounterRoute>
    
    
    // MARK: - Init
    convenience init() {
        let calendarCoordinator = CalendarCoordinator()
        calendarCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Calendar", image: nil, tag: 0)
        let taskCounterCoordinator = TaskCounterCoordinator()
        taskCounterCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Task counter", image: nil, tag: 1)
        self.init(calendarRouter: calendarCoordinator.anyRouter, taskCounterRouter: taskCounterCoordinator.anyRouter)
    }
    
    init(calendarRouter: AnyRouter<CalendarRoute>, taskCounterRouter: AnyRouter<TaskCounterRoute>) {
        self.calendarRouter = calendarRouter
        self.taskCounterRouter = taskCounterRouter
        super.init(tabs: [calendarRouter, taskCounterRouter], select: 0)
    }
    
    // MARK: - Overrides
    override func prepareTransition(for route: MainRoute) -> TabBarTransition {
        switch route {
        case .calendar:
            return .select(calendarRouter)
        case .taskCounter:
            return .select(taskCounterRouter)
        }
    }
    
}
