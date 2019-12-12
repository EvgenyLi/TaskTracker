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
            doneButtonTapped: doneButton.rx.tap.asSignal(),
            minusTapped: minus.rx.tap.asSignal(),
            plusTapped: plus.rx.tap.asSignal(),
            recognizer: recognizer.asSignal()
        )
    }
    
    func bindViewModel(to viewModel: EventViewModel) -> Disposable {
        return Disposables.create([viewModel.counterLabel.drive(label.rx.text)])
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecognizer()
    }
    
    // MARK: - Private
    private var disposeBag = DisposeBag()
    private var recognizer = PublishRelay<UISwipeGestureRecognizer>()
    
    private func setupRecognizer() {
        let swipe = UISwipeGestureRecognizer()
        self.view.addGestureRecognizer(swipe)
        _ = swipe.rx.event.bind(to: recognizer)
    }
}
