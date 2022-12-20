//
//  LodingAndLoginView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/18.
//

import SwiftUI

struct LodingAndLoginView: View {
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    var body: some View {
        // 로딩 - 로그인뷰를 자연스럽게 연결하기 위해서 사용
        if loginSignupStore.lodingViewChanger {
            LodingView()
        } else {
            LoginView()
        }
    }
}

struct LodingAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LodingAndLoginView()
            .environmentObject(LoginSignupStore())
    }
}
