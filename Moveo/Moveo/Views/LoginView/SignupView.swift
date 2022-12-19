//
//  SignupView.swift
//  Moveo
//
//  Created by 전근섭 on 2022/12/19.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Spacer()
                
                TextField("Name", text: $loginSignupStore.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $loginSignupStore.signUpEmail)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $loginSignupStore.signUpPw)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
                
                Button {
                    loginSignupStore.createNewAccount()
                    dismiss()
                } label: {
                    Text("회원가입")
                }

                
            }
            .padding(.horizontal)
            .navigationTitle("회원가입")
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(LoginSignupStore())
    }
}
