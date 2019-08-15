//
//  TaskCounterViewController.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 21/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import UIKit
import RxSwift

class TaskCounterViewController: UIViewController, BindableType {
    

    
    // MARK: Dependencies
    var viewModel: TaskCounterViewModel!
    
    // MARK: BindableType
    var output: TaskCounterViewModel.Input {
        return TaskCounterViewModel.Input()
    }
    
    func bindViewModel(to viewModel: TaskCounterViewModel) -> Disposable {
        return Disposables.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
