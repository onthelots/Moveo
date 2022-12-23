////
////  MoveoApp.swift
////  Moveo
////
////  Created by 진준호 on 2022/12/17.
////
//
//import SwiftUI
//import FirebaseCore
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
////      LoginSignupStore().fetchUser()
////      //LoginSignupStore().loginUser()
////      LoginSignupStore().currentUserDataInput()
//
//
//    return true
//  }
//}
//
//@main
//struct MoveoApp: App {
//
//    //@Environment(\.scenePhase) var scenePhase
//    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    //MARK: - inManager 인스턴스 StateObjcet로 선언 (다른 뷰에서도 계속 사용됨)
//    @StateObject var inManager = NotificationManager()
//
////
////
////    init() {
////        FirebaseApp.configure()
////
////
////    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(PostStore())
//                .environmentObject(LoginSignupStore())
//                .environmentObject(SampleTask())
//                .environmentObject(CommentStore())
//                .environmentObject(LikeStore())
//                .environmentObject(FollowStore())
//            //MARK: - environment 선언 -> inManager, Schedule, NotificationManager
//                .environmentObject(inManager)
//                .environmentObject(Schedule())
//                .environmentObject(NotificationManager())
//        }
////        .onChange(of: scenePhase) { newScenePhase in
////            switch newScenePhase {
////            case .active:
////                print("App is active")
////                LoginSignupStore().fetchUser()
////                //LoginSignupStore().loginUser()
////                LoginSignupStore().currentUserDataInput()
////            case .inactive:
////                print("App is inactive")
////            case .background:
////                print("App is in background")
////            @unknown default:
////                print("unexpected Value")
////                LoginSignupStore().fetchUser()
////                //LoginSignupStore().loginUser()
////                LoginSignupStore().currentUserDataInput()
////            }
////        }
//    }
//}
//
//
////import SwiftUI
////import UIKit
////
////// no changes in your AppDelegate class
////class AppDelegate: NSObject, UIApplicationDelegate {
////    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
////        print(">> your code here !!")
////        return true
////    }
////}
////
////@main
////struct Testing_SwiftUI2App: App {
////
////    // inject into SwiftUI life-cycle via adaptor !!!
////    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
////
////    var body: some Scene {
////        WindowGroup {
////            ContentView()
////        }
////    }
////}
import SwiftUI
import Firebase

@main
struct MoveoApp: App {
    
    //MARK: - inManager 인스턴스 StateObjcet로 선언 (다른 뷰에서도 계속 사용됨)
    @StateObject var inManager = NotificationManager()
    @StateObject var myEvents = EventStore(preview: true)

    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PostStore())
                .environmentObject(LoginSignupStore())
                .environmentObject(CommentStore())
                .environmentObject(LikeStore())
                .environmentObject(FollowStore())
            //MARK: - environment 선언 -> inManager, NotificationManager
                .environmentObject(inManager)
                .environmentObject(NotificationManager())
                .environmentObject(myEvents)
        }
    }
}
