//
//  HomeViewModel.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/18.
//

import Foundation

class Schedule: ObservableObject {
    @Published var schedulesFinished: Bool = false
//    @Published var scheduleIsEmpty: Bool = true
}

// 샘플 task
class SampleTask: ObservableObject {
    @Published var tasks: [TaskMetaData] = [
//        TaskMetaData(task: [
//            Task(title: "밥하기"),
//            Task(title: "밥 먹기"),
//            Task(title: "설거지하기")
//        ], taskDate: getSampleDate(offset: 0), taskTime: Date()
//        ),
//
//        TaskMetaData(task: [
//            Task(title: "청소하기"),
//            Task(title: "학교 가기"),
//            Task(title: "수업 듣기")
//        ], taskDate: getSampleDate(offset: -5), taskTime: Date()
//        )
    ]
    
    // date 타입을 sort 하는 방법을 찾아야한다...
    @Published var sortedTasks: [TaskMetaData] = []
    
    @Published var scheduledTime: Date = Date()
    
    init() {
        sortTasks()
    }
    
    func sortTasks() {
         sortedTasks = sortedTasks.sorted { (one, two) -> Bool in
            return one.taskTime > two.taskTime
        }
    }
    
    func deleteSchedule(i: TaskMetaData) {
//        sortedTasks = sortedTasks.filter() { $0 != i }
    }
    
}
