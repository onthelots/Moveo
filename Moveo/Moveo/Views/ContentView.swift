//
//  ContentView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

extension Color{
    static let mainColor = Color("mainColor")
    static let backgroundColor = Color("backgroundColor")
    static let pointGray = Color("pointGray")
}

struct ContentView: View {
    @EnvironmentObject var loginSignStore: LoginSignupStore
    
    var body: some View {
        // MARK: 현재 로그인 상태를 확인해서 로그인 상태면 메인뷰로 아니면 로그인뷰로 화면 출력
            if loginSignStore.$currentUser != nil {
                ContainTabView()
            } else {
                LodingAndLoginView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginSignupStore())
    }
}
