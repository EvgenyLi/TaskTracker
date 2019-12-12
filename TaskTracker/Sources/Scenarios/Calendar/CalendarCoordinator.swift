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
    case newEvent
    case dismiss
}
final class CalendarCoordinator: NavigationCoordinator<CalendarRoute> {
    
    init() {
        super.init(initialRoute: .initial)
    }
    
    override func prepareTransition(for route: CalendarRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let calendarViewController = CalendarViewController()
            let viewModel = CalendarViewModel(router: anyRouter)
            calendarViewController.bind(to: viewModel)
            _ = viewModel.setup(with: calendarViewController.output)
            if !event.eventName.isEmpty { calendarViewController.newEvent(self.event) }
            return .push(calendarViewController)
        case .newEvent:
            let eventViewController = EventViewController()
            let viewModel = EventViewModel(router: anyRouter)
            eventViewController.bind(to: viewModel)
            _ = viewModel.setup(with: eventViewController.output)
            return .present(eventViewController)
        case .dismiss:
           // self.event = event
            return .dismiss()
        }
    }
    
    private var event = CalendarEvent(eventName: "", isDone: true)
}
