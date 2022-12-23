//
//  LoginView.swift
//  Moveo
//
//  Created by 진준호 on 2022/11/29.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userStore : LoginSignupStore

    @State private var dismissedToRoot : Bool = false
    @State private var aniOpacity: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 40)
                    .padding(.top, 65)
                
                VStack {
                    Group {
                        TextField("Email@email.com", text: $userStore.email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $userStore.password)
                    }
                    .padding(10)
                    .background(Color.pointGray)
                    .padding(.horizontal, 30)
                    
                    Button {
                        userStore.loginUser()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 335, height: 45)
                                .cornerRadius(5)
                                .foregroundColor(.mainColor)
                            Text("로그인")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                    }
                    .disabled(userStore.email.isEmpty || userStore.password.isEmpty ? true : false)
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Text("아직 회원이 아니신가요?")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: SignUpView(dissmissStart: $dismissedToRoot), isActive: self.$dismissedToRoot) {
                            Text("회원가입")
                        }
                        .isDetailLink(false)
                    }
                    .padding(.bottom, 10)
                }
                .opacity(aniOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        aniOpacity = 1
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginSignupStore())
    }
}
