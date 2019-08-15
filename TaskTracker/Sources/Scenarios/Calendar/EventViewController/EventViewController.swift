//
//  EventViewController.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 29/06/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxFeedback

fileprivate enum Event {
    case increment
    case decrement
}

fileprivate enum State {
    case one
    case two
}

extension State {
    
    static func reduce(state: State, event: Event) -> State {
        switch event {
        case .increment:
            return .one
        case .decrement:
            return .two
        }
    }
}

class EventViewController: UIViewController, BindableType {
    
    // MARK: IBOutlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var label: UILabel!
    
    // MARK: Dependencies
    var viewModel: EventViewModel!
    
    // MARK: - BindableType
    var output: EventViewModel.Input {
        return EventViewModel.Input(
            doneButtonTapped: doneButton.rx.tap.asSignal()
        )
    }
    
    func bindViewModel(to viewModel: EventViewModel) -> Disposable {
        return Disposables.create()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // MARK: - Private
    private var disposeBag = DisposeBag()
}
