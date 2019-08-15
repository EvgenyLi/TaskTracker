//
//  ObservableExtension.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 17/07/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift

extension ObservableType {
    static func create<T>(with element: T) -> Observable<T> {
        return Observable<T>.create { observer in
            observer.onNext(element)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func consumeError() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func retryWithDelay(timeInterval: Double) -> Observable<Element> {
        return retryWhen { error -> Observable<Void> in
            return error
                .flatMap { _ -> Observable<Void> in
                    return Observable<Void>
                        .create(with: Void())
                        .delay(timeInterval, scheduler: MainScheduler.instance)
            }
        }
    }
    
    func once() -> Observable<Element> {
        return single()
            .catchError { _ -> Observable<Element> in
                return Observable.never()
        }
    }
}
