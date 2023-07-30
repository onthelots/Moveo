//
//  TaskListView.swift
//  Moveo
//
//  Created by Jae hyuk Yim on 2022/12/21.
//

import SwiftUI


// MARK: - 사용자가 입력한 일정을 보여주는 TaskListView
struct TaskListView: View {
    
    @EnvironmentObject var myEvents: EventStore
    @State private var formType: EventFormType?
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(myEvents.events.sorted {$0.date < $1.date }) { event in
                    TaskListRow(event: event, formType: $formType)
                    .swipeActions {
                        Button(role: .destructive) {
                            myEvents.delete(event)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(EventStore(preview: true))
    }
}
