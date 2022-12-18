//
//  ContainTabView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import SwiftUI

struct ContainTabView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView {
                MainView()
            }.tabItem {
                Image(systemName:"house.fill")
                Text("홈")
            }.tag(1)
     
            NavigationView {
                FeedView()
            }.tabItem {
                Image(systemName:"square.on.square.badge.person.crop.fill")
                Text("피드")
            }.tag(2)

            NavigationView {
                SearchView()
            }.tabItem {
                Image(systemName:"magnifyingglass")
                Text("찾기")
            }.tag(3)
            
            NavigationView {
                ProfileView()
            }.tabItem {
                Image(systemName:"person.fill")
                Text("프로필")
            }.tag(4)
        }
    }
}

struct ContainTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContainTabView()
            .environmentObject(ViewStore())
    }
}
