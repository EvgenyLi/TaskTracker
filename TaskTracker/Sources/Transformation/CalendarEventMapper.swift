//
//  CalendarEventMapper.swift
//  TaskTracker
//
//  Created by Evgeny Lipadat on 03/08/2019.
//  Copyright © 2019 Evgeny Lipadat. All rights reserved.
//

import RealmSwift

class CalendarEventMapper {
    
    static func map(from realm: RealmCalendarEvent) -> CalendarEvent {
        return CalendarEvent(eventName: realm.eventName, isDone: realm.isDone)
    }
    
    static func map(from entity: CalendarEvent) -> RealmCalendarEvent {
        return RealmCalendarEvent(eventName: entity.eventName, isDone: entity.isDone)
    }
}
