//
// Created for UICalendarView_SwiftUI


/// EventFormViewModel은 왜 필요한가?
/// 사용자가 새로운 일정을 등록하거나, 수정(update)할 수 있도록 2가지 경우를 만들기 위함
/// 따라서, 새로운 게시 프로퍼티를 선언하고,  Event 모델에서의 사용자 값을 초기값으로 할당함

import Foundation

// MARK: - EventForm을 보여주는 별도의 뷰 모델을 설정
class EventFormViewModel: ObservableObject {
    
    @Published var date = Date()
    @Published var note = ""
    @Published var eventType: Event.EventType = .선택

    var id: String?
    
    // 수정(업데이트)을 할 경우, 해당 id값을 유지함
    var updating: Bool { id != nil }

    init() {}

    init(_ event: Event) {
        date = event.date
        note = event.note
        eventType = event.eventType
        id = event.id
    }

    var incomplete: Bool {
        note.isEmpty
    }
}
