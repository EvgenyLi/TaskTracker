//
//  ModuleViewModel.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 25/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift

public protocol ModuleViewModel: class {
    
    associatedtype Input
    
    func setup(with input: Input) -> Disposable

}
