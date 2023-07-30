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
