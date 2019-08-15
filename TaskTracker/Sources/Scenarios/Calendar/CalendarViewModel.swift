//
//  CalendarViewModel.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 25/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator

class CalendarViewModel: ModuleViewModel {
    
    
    let router: AnyRouter<CalendarRoute>
    
    init(router: AnyRouter<CalendarRoute>) {
        self.router = router
    }
    
    // MARK: - ModuleViewModel
    struct Input {
        let addEventButtonTapped: Signal<Void>
    }
    
    func setup(with input: Input) -> Disposable {
        return Disposables.create(
            [input.addEventButtonTapped
                .asObservable()
                .flatMapFirst { [weak self] _ -> Completable in
                    guard let self = self else { return .empty() }
                    return self.router.rx.trigger(.newEvent)
                }.subscribe()]
        )
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
