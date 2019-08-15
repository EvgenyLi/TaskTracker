//
//  CalendarEvent.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 02/08/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RealmSwift

class RealmCalendarEvent: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var isDone: Bool = false
    
    convenience init(eventName: String, isDone: Bool) {
        self.init()
        
        self.eventName = eventName
        self.isDone = isDone
    }
}
