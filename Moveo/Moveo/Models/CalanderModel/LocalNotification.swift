//
//  LocalNotification.swift
//  KavasoftCustomCalendar
//
//  Created by Jae hyuk Yim on 2022/12/21.
//

import Foundation

struct LocalNotification {

    internal init(identifier: String,
                  title: String,
                  timeInterval: Double,
                  repeats: Bool) {
        self.identifier = identifier
        self.title = title
        self.timeInterval = timeInterval
        self.dateComponets = nil
        self.repeats = repeats
        
        self.scheduleType = .time
    }
    

    internal init(identifier: String,
                  title: String,
//                  body: String,
//                  timeInterval: Double? = nil,
                  dateComponets: DateComponents,
                  repeats: Bool) {
        self.identifier = identifier
        self.title = title
//        self.body = body
        self.timeInterval = nil
        self.dateComponets = dateComponets
        self.repeats = repeats
        self.scheduleType = .calender
    }

    enum ScheduleType {
        case time, calender
    }
    

    var identifier: String
    var title: String
//    var body: String
    var subtitle: String?
    
    var scheduleType: ScheduleType
    var timeInterval: Double?
    var dateComponets: DateComponents?
    
    // TODO: - 캘린더 타입의 store를 하나 생성해서, dateComponets에서 받아오는 데이터를 변환, 저장하도록 한다
    var repeats: Bool
}
