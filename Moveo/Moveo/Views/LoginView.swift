//
//  LoginView.swift
//  Moveo
//
//  Created by 진준호 on 2022/11/29.
//

import SwiftUI

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("loginView")
                    .resizable()
                
                ZStack {
                    TextField(text: $id) {
                        Text("아이디를 입력해주세요")
                    }
                    .zIndex(1)
                    .padding(.leading, 50)
                    
                    Rectangle()
                        .frame(width: 328, height: 52)
                        .cornerRadius(8)
                        .foregroundColor(.pointGray)
                }
                .offset(y: -30)
                
                ZStack {
                    TextField(text: $id) {
                        Text("비밀번호를 입력해주세요")
                    }
                    .zIndex(1)
                    .padding(.leading, 50)
                    
                    Rectangle()
                        .frame(width: 328, height: 52)
                        .cornerRadius(8)
                        .foregroundColor(.pointGray)
                }
                .offset(y: 30)
                
                NavigationLink(destination: MainView()) {
                    ZStack {
                        Rectangle()
                            .frame(width: 328, height: 52)
                            .cornerRadius(8)
                            .foregroundColor(.mainColor)
                        Text("로그인")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                .offset(y: 100)
                
                Text("비밀번호를 잊으셨나요?")
                    .offset(y:150)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
