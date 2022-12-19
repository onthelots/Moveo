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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            ContentView()
                .environmentObject(ViewStore())
                .environmentObject(PostStore())
                .environmentObject(LoginSignupStore())
        }
    }
}
