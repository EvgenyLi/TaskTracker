//
//  BindableType.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 25/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol BindableType: AnyObject {
    associatedtype ViewModelType: ModuleViewModel
    
    var viewModel: ViewModelType! { get set }
    var output: ViewModelType.Input { get }
    
    func bindViewModel(to viewModel: ViewModelType) -> Disposable
}

extension BindableType where Self: UIViewController {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        _ = bindViewModel(to: model)
    }
}

extension BindableType where Self: UITableViewCell {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        _ = bindViewModel(to: model)
    }
}

extension BindableType where Self: UICollectionViewCell {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        _ = bindViewModel(to: model)
    }
}
