//
//  TaskListRow.swift
//  Moveo
//
//  Created by Jae hyuk Yim on 2022/12/22.
//

import SwiftUI


// MARK: - 사용자가 입력한 일정을 보여주는 TaskListRow View
struct TaskListRow: View {
    
    
    // Event 값을 받아오기 위해 event 프로퍼티 만들고..
    let event: Event
    @Binding var formType: EventFormType?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(event.eventType.icon)
                        .font(.system(size: 40))
                    Text(event.note)
                }
                Text(
                    event.date.formatted(date: .abbreviated,
                                         time: .shortened)
                )
            }
            
            Spacer()
            
            Button {
                formType = .update(event)
            } label: {
                Text("Edit")
            }
            .buttonStyle(.bordered)
        }
    }
}

struct TaskListRow_Previews: PreviewProvider {
    static let event = Event(eventType: .예술, date: Date(), note: "Swift 문법 스터디 참여")
    static var previews: some View {
        TaskListRow(event: event, formType: .constant(.new))
        
    }
}
