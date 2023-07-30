//
// Created for UICalendarView_SwiftUI
// by Stewart Lynch on 2022-06-28
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import Foundation

struct Event: Identifiable {
    
    //MARK: - Event, 즉 카테고리 타입을 설정
    enum EventType: String, Identifiable, CaseIterable {
        case 공부, 운동, 예술, 멘탈케어, 자기계발, 선택
        var id: String {
            self.rawValue
        }
        //MARK: - Evnet 아이콘 초기화 -> enum내 케이스를 -> icon값을 할당
        var icon: String {
            switch self {
            case .공부:
                return "🏦"
            case .운동:
                return "🏡"
            case .예술:
                return "🎉"
            case .멘탈케어:
                return "🏟"
            case .자기계발:
                return "📚"
            case .선택:
                return "📌"
            }
        }
    }
    
    //MARK: - 기본 데이터 Store
    var eventType: EventType
    var date: Date
    var note: String
    var id: String
    
    //MARK: - DataComponets의 속성을 미리 정해버림
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year,
             .hour,
             .minute],
            from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    //MARK: - 초기화
    init(id: String = UUID().uuidString, eventType: EventType = .선택, date: Date, note: String) {
        self.eventType = eventType
        self.date = date
        self.note = note
        self.id = id
    }

    //MARK: - Preview에서 사용할 더미 데이터
    static var sampleEvents: [Event] {
        return [
            Event(eventType: .운동, date: Date().diff(numDays: 0), note: "Take dog to groomers"),
        ]
    }
}




//MARK: - Date에 기능 추가
extension Date {
    //MARK: - diff 해당 날짜(numDays)에 value를 추가
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    //MARK: - startOfDay 시작하는 날짜 (초기날짜)
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
