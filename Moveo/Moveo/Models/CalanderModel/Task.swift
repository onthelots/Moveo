//
//  Task.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/17.
//

import Foundation

// MARK: - Task이름 중복에 따른 TaskStore로 구조체 이름 수정
struct TaskStore: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// task meta view
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [TaskStore]
    var taskDate: Date
    var taskTime: Date
}

