//
//  Home.swift
//  KavasoftCalender
//
//  Created by 전근섭 on 2022/12/17.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var postStore : PostStore
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @State private var currentDate: Date = Date()
    @State private var showModal: Bool = false
    
    @EnvironmentObject var myEvents: EventStore
    @EnvironmentObject var eventStore: EventStore
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    @State private var formType: EventFormType?
    
    // MARK: - 로그인 창에서, 해당 알림권한 설정 기능을 추가함
    @EnvironmentObject var inManager: NotificationManager
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - 아이콘, 수정, 글쓰기 버튼
                HStack {
                    Image("moveoLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    Spacer()
                    
                    
                    NavigationLink {
                        // TODO: - 설정페이지 연결(알림에 대한 설정을 추가하게 된다면 사용 아니면 삭제)
                    } label: {
                        Image(systemName: "gearshape.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.mainColor)
                        
                    }
                    
                    NavigationLink {
                        AddPostView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.mainColor)
                    }
                }
            }
            // 위에 고정
            ScrollView {
                // MARK: - 캘린더 뷰 (카테고리 별 포스팅한 날짜를 받아와서 -> 해당 날에 색칠표시)
                VStack {
                    EventsCalendarView()
                }
                Divider()
                
                // MARK: - 일정계획 Title 및 일정 리스트 뷰
                HStack {
                    VStack {
                        Text("일정계획")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        if inManager.pendingRequests.count == 0 {
                            Text("일정을 등록해주세요")
                                .foregroundColor(.gray)
                                .font(.callout)
                                .fontWeight(.light)
                        } else {
                            Text("")
                        }
                    }
                }
                .padding()
                
                //MARK: - TaskList 할일 리스트
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(inManager.pendingRequests, id: \.identifier) { request in
                        VStack(alignment: .leading) {
                            Text(request.content.title)
                            Spacer()
                            HStack {
                                Text(request.identifier)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                inManager.removeRequest(withIdentifier: request.identifier)
                            } label: {
                                Text("Delete")
                            }
                        }
                    }
                }
            }
            
            // MARK: - 일정등록 ZStak 버튼
            ZStack {
                Button {
                    self.showModal = true
                } label: {
                    Image(systemName: "bell.circle.fill")
                        .font(.system(size: 50))
                        .shadow(radius: 1, x:1, y:1)
                }
                .sheet(isPresented: $showModal) {
                    AddTaskView(viewModel: EventFormViewModel())
                        .presentationDetents([.fraction(0.6)])
                }
                
            }
            .offset(x: 140, y: -50)
        }
        
        
        // MARK: - 로그인 버튼을 누를 경우, 권한설정 메세지가 발생함
        .task {
            try? await inManager.requestAuthorization()
        }
        // onChange 수정자를 통해 [scenePhase]기능을 추가하는데
        //
        
        // MARK: - 만약, 권한설정을 거절한 후, 설정창에서 수동으로 알림기능을 작동시킬 경우 scenePhase
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                Task {
                    await inManager.getCurrentSetting()
                    await inManager.getPendingRequests()
                }
            }
        }
        .onAppear {
            loginSignupStore.fetchUser()
            postStore.fetchPosts()
        }
        .padding(.horizontal, 10)
    }
}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(LoginSignupStore())
            .environmentObject(NotificationManager())
            .environmentObject(PostStore())
            .environmentObject(EventStore(preview: true))
    }
}
