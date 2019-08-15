//
//  EventViewModel.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 29/06/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator

class EventViewModel: ModuleViewModel {
    
   // private let dao = DAO()
    
    let router: AnyRouter<CalendarRoute>
    
    init(router: AnyRouter<CalendarRoute>) {
        self.router = router
    }
    
    // MARK: - ModuleViewModel
    struct Input {
        let doneButtonTapped: Signal<Void>
    }
    
    func setup(with input: EventViewModel.Input) -> Disposable {
        return Disposables.create([
        input.doneButtonTapped.asObservable()
            .flatMapFirst { [weak self] _ -> Completable in
                guard let self = self else { return .empty() }
                return self.router.rx.trigger(.dismiss)
            }
            .subscribe()
            ])
    }
    
    // MARK: - Public
//    var doneTapped: Observable<Completable> {
//     //   return doneRelay.asObservable().map { _ in self.router.rx.trigger(.dismiss) }
//    }
    
    // MARK: - Private
    let disposeBag = DisposeBag()
}
