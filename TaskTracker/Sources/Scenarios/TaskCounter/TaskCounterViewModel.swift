//
//  TaskCounterViewModel.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 05/06/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import XCoordinator
import RxSwift

class TaskCounterViewModel: ModuleViewModel {

    let router: AnyRouter<TaskCounterRoute>
    
    init(router: AnyRouter<TaskCounterRoute>) {
        self.router = router
    }
    
    // MARK: - ModuleViewModel
    struct Input {
        //
    }
    
    func setup(with input: TaskCounterViewModel.Input) -> Disposable {
        return Disposables.create()
    }
}
