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
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var inManager: NotificationManager
    
    @FocusState private var focus: Bool?
    @State private var scheduleDate = Date()
    @State private var title: String = ""

    var body: some View {
        NavigationStack {
            if inManager.isGranted {
                VStack {
                    Form {
                        DatePicker(selection: $viewModel.date) {
                            Text("Date and Time")
                        }
                        TextField("Note", text: $viewModel.note, axis: .vertical)
                            .focused($focus, equals: true)
                        Picker("Event Type", selection: $viewModel.eventType) {
                            ForEach(Event.EventType.allCases) {eventType in
                                Text(eventType.icon + " " + eventType.rawValue.capitalized)
                                    .tag(eventType)
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
                                    eventStore.update(event)
                                    
                                    inManager.schedule(eventInfo: event)
                                } else {
                                    // create new event
                                    let newEvent = Event(eventType: viewModel.eventType,
                                                         date: viewModel.date,
                                                         note: viewModel.note)
                                    eventStore.add(newEvent)
                                    
                                    inManager.schedule(eventInfo: newEvent)
                                }
                                dismiss()
                            } label: {
                                Text(viewModel.updating ? "Update Event" : "Add Event")
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
//        .navigationTitle(viewModel.updating ? "Update" : "New Event")
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
