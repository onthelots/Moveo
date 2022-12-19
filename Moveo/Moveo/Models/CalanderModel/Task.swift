//
//  Task.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/17.
//

import Foundation

// [task]
struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// task meta view
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
    var taskTime: Date
}

// 테스트를 위한 샘플 날짜
// 필요 없음
func getSampleDate(offset: Int) -> Date {
    let calender = Calendar.current
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

