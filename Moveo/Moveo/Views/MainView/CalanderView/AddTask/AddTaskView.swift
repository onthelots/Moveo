//
//  AddTaskView.swift
//  Moveo
//
//  Created by Jae hyuk Yim on 2022/12/21.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var eventStore: EventStore
    @StateObject var viewModel: EventFormViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var inManager: NotificationManager
    
    @FocusState private var focus: Bool?
    @State private var title: String = ""

    var body: some View {
        
        NavigationStack {
            if inManager.isGranted {
                
                VStack {
                    Form {
                        Section {
                            Text("오늘의 일정은?")
                                .foregroundColor(Color.mainColor)
                                .fontWeight(.bold)
                            VStack {
                                TextField("일정을 입력해 주세요.", text: $viewModel.note, axis: .vertical)
                                    .focused($focus, equals: true)
                            }
                        }
                        
                        Section {
                            DatePicker(selection: $viewModel.date) {
                                Text("날짜")
                                
                            }
                            Picker("활동유형", selection: $viewModel.eventType) {
                                ForEach(Event.EventType.allCases) {eventType in
                                    Text(eventType.icon + " " + eventType.rawValue.capitalized)
                                        .tag(eventType)
                                }
                            }
                        }
                        
                        Section(footer:
                                    HStack {
                            Spacer()
                            Button {
                                if viewModel.updating {
                                    // update this event
                                    let event = Event(id: viewModel.id!,
                                                      eventType: viewModel.eventType,
                                                      date: viewModel.date,
                                                      note: viewModel.note)
                                    
                                    // eventStore에 업데이트,
                                    eventStore.update(event)
                                    // inManager(알림기능)에도 업데이트
                                    inManager.schedule(eventInfo: event)
                                    
                                } else {
                                    // create new event
                                    let newEvent = Event(eventType: viewModel.eventType,
                                                         date: viewModel.date,
                                                         note: viewModel.note)
                                    // eventStore에 업데이트,
                                    eventStore.add(newEvent)
                                    // inManager(알림기능)에도 업데이트
                                    inManager.schedule(eventInfo: newEvent)
                                }
                                dismiss()
                            } label: {
                                Text(viewModel.updating ? "일정수정" : "일정추가")
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(viewModel.incomplete)
                            Spacer()
                        }
                        ) {
                            EmptyView()
                        }
                    }
                }
            } else {
                Button {
                    inManager.openSetting()
                } label: {
                    Text("알림 권한을 설정해주세요")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            focus = true
        }
        
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: EventFormViewModel())
            .environmentObject(NotificationManager())
            .environmentObject(EventStore(preview: true))
        
    }
}
