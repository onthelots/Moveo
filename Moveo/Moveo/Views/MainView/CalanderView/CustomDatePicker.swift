//
//  CustomDatePicker.swift
//  KavasoftCalender
//
//  Created by 전근섭 on 2022/12/17.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    
    @EnvironmentObject var sampleTasks: SampleTask
    
    // 화살표로 월 바꾸기
    @State private var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            // 월 view
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }

            }
            .padding(.horizontal)
            
            // 요일 view
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // 날짜 view
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background {
                            Capsule()
                                .fill(Color.orange)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            
                        }
                        .onTapGesture {
                            currentDate = value.date
                        }
                        
                }
            }
            .animation(.spring(), value: currentDate)
            
            // 오늘의 일정 view
// 같은 날에 일정을 여러 개 추가할 수 있는데 해당 날짜에 일정이 없을 때 "추가된 일정이 없습니다" 문구가 안 나옴
            VStack(spacing: 15) {
                Text("오늘의 일정")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                
                if let task = sampleTasks.sortedTasks.filter({ task in
                    isSameDay(date1: task.taskDate, date2: currentDate)
                }) {
//                if let _ = sampleTasks.tasks.first(where: { task in
//                    return isSameDay(date1: task.taskDate, date2: currentDate)
//                }) {
                
                    // schedule toggle 카드
                    ForEach(task, id: \.id) { t in
                        ForEach(t.task) { j in
                            HStack {    
                                ScheduleToggle(time: t.taskTime, title: j.title )
                                
                            }
                        }
                    }
                    
                    
                } else {
                    Text("추가된 일정이 없습니다")
                }
            }
            .animation(.spring(), value: currentDate)
            .padding()
            .padding(.top, 25)
            
            
// 이 코드를 쓰면 같은 날에 여러 일정을 추가하지 못한다. 대신 일정이 없을 때 "추가된 일정이 없습니다" 문구가 나옴
//
//            VStack(spacing: 15) {
//                Text("오늘의 일정")
//                    .font(.title2.bold())
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.vertical, 20)
//
//                if let task = sampleTasks.tasks.first(where: { task in
//                    return isSameDay(date1: task.taskDate, date2: currentDate)
//                }) {
//
//
//                    // 일정 완료 유무 확인 toggle
//                    ForEach(task.task) { t in
//                        HStack {
//                            ScheduleToggle(time: t.time, title: t.title)
//                        }
//                    }
//
//                } else {
//                    Text("추가된 일정이 없습니다")
//                }
//            }
//            .animation(.spring(), value: currentDate)
//            .padding()
//            .padding(.top, 25)
            
        }
        .onChange(of: currentMonth) { newValue in
            // 월 업데이트
            currentDate = getCurrentMonth()
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        sampleTasks.sortedTasks.remove(atOffsets: offsets)
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                
                if let task = sampleTasks.sortedTasks.first(where: { task in
                    
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color.orange)
                        .frame(width: 8, height: 8)
                } else {
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    // 날짜 확인하기
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // 뷰를 위한 년, 월 가져오기
    func extraDate() -> [String] {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    // 현재 월 가져오기
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        // 현재 월, 날짜 가져오기
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    // 주 정리하기
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        // 현재 월, 날짜 가져오기
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            // 요일 가져오기
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // 주를 위한 offset 추가
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SampleTask())
            .environmentObject(Schedule())
    }
}

// 현재 월, 요일, 시간을 갖고오기
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // 시작 날짜 가져오기
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        // date 가져오기
        return range.compactMap({ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        })
    }
}
