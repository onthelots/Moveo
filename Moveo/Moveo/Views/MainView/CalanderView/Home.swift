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
    @State private var bottomSheetActivated: Bool = false
    
    // MARK: - 로그인 창에서, 해당 알림권한 설정 기능을 추가함
    @EnvironmentObject var inManager: NotificationManager
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // custom date picker
                    CustomDatePicker(currentDate: $currentDate)
                }
                .padding(.vertical)
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    bottomSheetActivated.toggle()
                } label: {
                    Text("일정 추가")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange, in: Capsule())
                }
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .sheet(isPresented: $bottomSheetActivated) {
                    AddSchedule()
                        .presentationDetents([.medium, .large])
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
            }
        }
        .onAppear{
            loginSignupStore.fetchUser()
            postStore.fetchPosts()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(SampleTask())
            .environmentObject(LoginSignupStore())
            .environmentObject(NotificationManager())
            .environmentObject(PostStore())
    }
}
