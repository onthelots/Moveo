//
//  AddSchedule.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/18.
//

import SwiftUI

struct AddSchedule: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var inManager: NotificationManager
    @EnvironmentObject var sampleTasks: SampleTask
    @State private var todoTitle: String = ""
    @State private var scheduledDay: Date = Date()
    @State private var scheduledTime: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                if inManager.isGranted {
                    Form {
                        Section {
                            TextField("할 일", text: $todoTitle)
                            DatePicker("날짜", selection: $scheduledDay, displayedComponents: .date)
                            DatePicker("시간", selection: $scheduledTime, displayedComponents: .hourAndMinute)
                        } header: {
                            Text("추가할 목록")
                        }
                        
                    }
                    .background(.ultraThinMaterial)
                    .navigationTitle("일정 추가")
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button {
                                addScheduleToTasks(time: scheduledTime)
                                print("add schedule to tasks")
                                dismiss()
                                print("Dismiss")
                                
                                
                            } label: {
                                Text("추가")
                            }
                        })
                    }
                } else {
                    Button {
                        inManager.openSetting()
                    } label: {
                        Text("Enable Notifications")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
//        .task {
//                // TODO: - 알람Store(LocalNotification)에는 데이터가 저장되어 알람이 울리는데
//                // TODO: - Task로 묶여서 버튼 내에 넣어주면 일정 추가가 안됨 (해결 필요)
//                let dateComponets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: scheduledTime)
//                var localNotification = LocalNotification(identifier: UUID().uuidString,
//                                                          title: todoTitle,
//                                                          dateComponets: dateComponets,
//                                                          repeats: false)
//
//                await inManager.schedule(localNotification: localNotification)
//
//                print("await schedule")
//
//        }
    }

    func addScheduleToTasks(time: Date) {
        sampleTasks.sortedTasks.append(contentsOf: [TaskMetaData(task: [TaskStore(title: todoTitle)], taskDate: scheduledTime, taskTime: time)]
        )
        print("\(sampleTasks.sortedTasks)")
    }
}

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
            .environmentObject(SampleTask())
            .environmentObject(NotificationManager())
    }
}
