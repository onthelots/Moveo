//
//  ScheduleToggle.swift
//  KavasoftCustomCalendar
//
//  Created by 전근섭 on 2022/12/18.
//

import SwiftUI

struct ScheduleToggle: View {
    
//    var scheduleTitle: String
//    @State private var scheduleFinishedToggle = false
    @ObservedObject private var vm: Schedule = Schedule()
    @EnvironmentObject var sampleTasks: SampleTask
    
    @State var time: Date
    @State var title: String
    
    var body: some View {
//        if vm.scheduleIsEmpty {
//            Text("추가된 일정이 없습니다")
//        } else {
            HStack {
                Toggle(isOn:  $vm.schedulesFinished) {
                    VStack(alignment: .leading, spacing: 10) {
                        // 랜덤 시간        시간 간격 추가 기능
                        Text("\(time, style: .time)")

                        Text(title)
                            .font(.title2.bold())

                        Text("\(vm.schedulesFinished ? "완료" : "진행중")")

                    }
                }
                .animation(.none, value: vm.schedulesFinished)
            }
            .foregroundColor(Color.white)
            .padding(.vertical)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                vm.schedulesFinished ? Color.orange : Color(.secondaryLabel)
            }
            .animation(.easeInOut(duration: 0.5), value: vm.schedulesFinished)
            .cornerRadius(10)
            .contextMenu {
                Button {
//                    deleteSchedule(at: <#IndexSet#>)
                } label: {
                    Label("삭제하기", systemImage: "trash")
                }

            }
//        }
        
    }
    
    func deleteSchedule(at offsets: IndexSet) {
        sampleTasks.sortedTasks.remove(atOffsets: offsets)
    }
}

struct ScheduleToggle_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleToggle(time: Date.now, title: "책 보기")
            .environmentObject(SampleTask())
    }
}
