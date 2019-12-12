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
    
    // MARK: - Dependencies
    let router: AnyRouter<CalendarRoute>
    
    init(router: AnyRouter<CalendarRoute>) {
        self.router = router
    }
    
    // MARK: - ModuleViewModel
    struct Input {
        let doneButtonTapped: Signal<Void>
        let minusTapped: Signal<Void>
        let plusTapped: Signal<Void>
        let recognizer: Signal<UISwipeGestureRecognizer>
    }
    
    func setup(with input: EventViewModel.Input) -> Disposable {
        return Disposables.create([
        input.doneButtonTapped.asObservable()
            .flatMapFirst { [weak self] _ -> Completable in
                guard let self = self else { return .empty() }
                return self.router.rx.trigger(.dismiss)
            }
            .subscribe(),
        input.minusTapped.asObservable()
            .withLatestFrom(counterRelay.asObservable())
            .map { $0 - 1 }
            .bind(to: counterRelay),
        input.plusTapped.asObservable()
            .withLatestFrom(counterRelay.asObservable())
            .map { $0 + 1 }
            .bind(to: counterRelay),
        input.recognizer.asObservable()
            .flatMapLatest { recognizer -> Observable<Int> in
                switch recognizer.direction {
                    case .left: return .just(self.counterRelay.value + 1)
                    case .right: return .just(self.counterRelay.value - 1)
                    default: return .just(self.counterRelay.value)
                }
            }
            .bind(to: counterRelay)
            ])
    }
    
    // MARK: - Public
    var counterLabel: Driver<String> {
        return counterRelay.map { String($0) }.asDriver(onErrorJustReturn: "0")
    }
    
    // MARK: - Private
    private let counterRelay = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
}
