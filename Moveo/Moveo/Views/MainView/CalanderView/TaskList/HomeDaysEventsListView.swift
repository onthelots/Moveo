//
//  HomeDaysEventsListView.swift
//  Moveo
//
//  Created by Jae hyuk Yim on 2022/12/23.
//

import SwiftUI

struct HomeDaysEventsListView: View {
    @State private var dateSelected: DateComponents?
    var body: some View {
        VStack {
            TaskListView()
        }
    }
}

struct HomeDaysEventsListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDaysEventsListView()
            .environmentObject(EventStore(preview: true))
    }
}
