//
//  CalendarEvent.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 02/08/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import Foundation
import RealmSwift

class CalendarEvent: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var isDone: Bool = false
}
