//
//  Coordinator.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 21/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import XCoordinator

enum TaskCounterRoute: Route {
    case initial
}

final class TaskCounterCoordinator: NavigationCoordinator<TaskCounterRoute> {
    
    init() {
        super.init(initialRoute: .initial)
    }
    
    override func prepareTransition(for route: TaskCounterRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let taskCounterViewController = TaskCounterViewController()
            let viewModel = TaskCounterViewModel(router: anyRouter)
            taskCounterViewController.bind(to: viewModel)
            return .push(taskCounterViewController)
        }
    }
}
