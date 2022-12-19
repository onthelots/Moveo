//
//  LoginView.swift
//  Moveo
//
//  Created by 진준호 on 2022/11/29.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewStore: ViewStore
    
    // TODO: - LoginStore 만들고 난 후 삭제할 변수들
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var aniOpacity: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 40)
                    .padding(.top, 65)
                
                VStack {
                    Group {
                        TextField("Email", text: $id)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(10)
                    .background(Color.pointGray)
                    .padding(.horizontal, 30)
                    
                    Button {
                        viewStore.currentLoginCheckViewChanger = false
                        // MARK: - LoginStore login 함수 자리
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
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        Text("아직 회원이 아니신가요?")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        // TODO: - 회원가입 뷰 만들면 destination 수정 필요
                        NavigationLink(destination: SignupView()) {
                            Text("회원가입")
                                .font(.callout)
                                .foregroundColor(.blue)
                        }
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
            .environmentObject(ViewStore())
    }
}
