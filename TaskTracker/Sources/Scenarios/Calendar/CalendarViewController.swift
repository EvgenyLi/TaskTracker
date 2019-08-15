//
//  CalendarViewController.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 21/05/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import UIKit
import XCoordinator
import RxSwift
import FSCalendar


class CalendarViewController: UIViewController, UIGestureRecognizerDelegate, BindableType {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
     // MARK: Private
    private var tasks: [String: [RealmCalendarEvent]] = [:]
    private let disposeBag = DisposeBag()

    // MARK: Dependencies
    var viewModel: CalendarViewModel!
    
    // MARK: BindableType
    var output: CalendarViewModel.Input {
        return CalendarViewModel.Input(
            addEventButtonTapped: (navigationItem.rightBarButtonItem?.rx.tap
                .asSignal())!)
    }
    
    func bindViewModel(to viewModel: CalendarViewModel) -> Disposable {
        return Disposables.create(
            //
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarConfig()
        tableViewConfig()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func calendarConfig() {
        self.calendar.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .week
    }
    private func tableViewConfig() {
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            @unknown default:
                print("@unknown default")
            }
        }
        return shouldBegin
    }
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks.values.first?[indexPath.row].eventName
        return cell
    }
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}

    // MARK:- FSCalendarDataSource, FSCalendarDelegate
extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
//        DAO().saveData(entities: CalendarEvent) { calendarEvent -> RealmCalendarEvent in
//            return CalendarEventMapper.map(from: calendarEvent)
//        }
        
//        if let tasks = UserDefaults.standard.object(forKey: self.dateFormatter.string(from: date)) as? [String] {
//            self.tasks = tasks
//        } else {
//            self.tasks = []
//            self.tableView.reloadData()
//        }
        tableView.reloadData()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}
