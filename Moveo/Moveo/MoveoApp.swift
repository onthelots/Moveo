//
//  MoveoApp.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI
import Firebase

@main
struct MoveoApp: App {
    
    //MARK: - inManager 인스턴스 StateObjcet로 선언 (다른 뷰에서도 계속 사용됨)
    @StateObject var inManager = NotificationManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PostStore())
                .environmentObject(LoginSignupStore())
                .environmentObject(SampleTask())
                .environmentObject(CommentStore())
                .environmentObject(LikeStore())
                .environmentObject(FollowStore())
            //MARK: - environment 선언 -> inManager, Schedule, NotificationManager
                .environmentObject(inManager)
                .environmentObject(Schedule())
                .environmentObject(NotificationManager())
        }
    }
}
