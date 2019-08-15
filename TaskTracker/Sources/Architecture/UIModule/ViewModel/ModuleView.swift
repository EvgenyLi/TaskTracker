//
//  ModuleView.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 30/06/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RxSwift

public protocol ModuleView: class {
    
    associatedtype ViewModel: ModuleViewModel
    
    var output: ViewModel.Input { get }
    
    var viewModel: ViewModel { get }
    
    func setupBindings(to viewModel: ViewModel) -> Disposable
    
    func bindViewModel(_ viewModel: ViewModel)
    
    func unbindViewModel()
}

public extension ModuleView where Self: NSObjectProtocol {
    
    var viewModel: ViewModel {
        assertMainThread()
        guard let viewModel = viewModelBox?.viewModel else {
            fatalError("ViewModel is not bound")
        }
        return viewModel
    }
    
    func bindViewModel(_ viewModel: ViewModel) {
        unbindViewModel()
        viewModelBox = with(ViewModelBox(viewModel)) { box in
            viewModel.setup(with: output).disposed(by: box.disposeBag)
            setupBindings(to: viewModel).disposed(by: box.disposeBag)
        }
    }
    
    func unbindViewModel() {
        assertMainThread()
        viewModelBox = nil
    }
}

fileprivate extension ModuleView where Self: NSObjectProtocol {
    
    var viewModelBox: ViewModelBox<ViewModel>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewModelBox) as? ViewModelBox<ViewModel>
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewModelBox, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private enum AssociatedKeys {
    static var viewModelBox: Int32 = 0
}

private class ViewModelBox<ViewModel> {
    
    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

public func assertMainThread(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
    assert(Thread.isMainThread, "function \(String(describing: function)) must be used from the main thread", file: file, line: line)
}

@discardableResult
public func with<T>(_ object: T, do block: (T) -> Void) -> T {
    block(object)
    return object
}

@discardableResult
public func withRef<T>(_ valueRef: inout T, do block: (inout T) -> Void) -> T {
    block(&valueRef)
    return valueRef
}
