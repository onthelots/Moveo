//
//  SignUpView.swift
//  PlantsAndPets
//
//  Created by 전근섭 on 2022/12/13.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    @State private var nickName: String = ""
    @State private var isCorrect: Bool = false
    
    @Binding var dissmissStart: Bool
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("회원가입")
                .font(.title2)
                .bold()
            
            
            Spacer()
            
            VStack(alignment: .leading) {
                NameInputs()
                IDInputs()
                
                Text("닉네임")
                    .bold()
                HStack {
                    TextField("닉네임", text: $loginSignupStore.nickName)
                        .shadow(radius: 2, y:1)
                        
                        .disableAutocorrection(true)
                    
                    Button {
                        loginSignupStore.nickName = ""
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.bottom)
                
                PassWordInputs()
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 50)
            
            NavigationLink(destination: ProfileImageSetupView(dismissToRoot: $dissmissStart)) {
                Text("다음")
            }
            .isDetailLink(false)
            .padding(.horizontal, 152)
            .padding(.vertical, 15)
            .foregroundColor(.white)
            .background(Color.mainColor)
            .cornerRadius(10)
            .disabled((loginSignupStore.signUpPw == loginSignupStore.signUpPwCheck) && (loginSignupStore.signUpPwCheck.count != 0) ? false : true)
            
            Spacer()
        }
        .autocapitalization(.none)
        
    }
}

struct PassWordInputs: View {
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    @State private var pw: String = ""
    @State private var pwCheck: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("비밀번호")
                    .bold()
                HStack {
                    SecureField("비밀번호", text: $loginSignupStore.signUpPw)
                        .shadow(radius: 2, y:1)
                        .disableAutocorrection(true)
                    
                    Button {
                        loginSignupStore.signUpPw = ""
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }

                }
            }
            if loginSignupStore.signUpPw.count < 6{
                Text("비밀번호를 6자리 이상 입력해주세요")
                    .foregroundColor(.red)
            } else {
                Text("")
            }
            
            
            Group {
                Text("비밀번호 확인")
                    .padding(.top, 8)
                    .bold()
                HStack {
                    SecureField("비밀번호 재입력", text: $loginSignupStore.signUpPwCheck)
                        .shadow(radius: 2, y:1)
                        .disableAutocorrection(true)
                    
                    Button {
                        loginSignupStore.signUpPwCheck = ""
                    } label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }

                }
            }
            
            
            if (loginSignupStore.signUpPw == loginSignupStore.signUpPwCheck) && (loginSignupStore.signUpPwCheck.count != 0) {
                Text("비밀번호가 일치합니다")
                    .foregroundColor(.green)
            } else if loginSignupStore.signUpPw.isEmpty {
                Text("")
            } else if (loginSignupStore.signUpPw != loginSignupStore.signUpPwCheck) {
                Text("비밀번호가 일치하지 않습니다")
                    .foregroundColor(.red)
            }
        }
        .padding(.bottom)
        
    }
}

struct IDInputs: View {
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    @State private var id: String = ""
    @State private var idNotOverlaped: Bool = false
    @State private var idNotOverlapedColor: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("아이디")
                .bold()
            HStack {
                TextField("email@email.com", text: $loginSignupStore.signUpEmail)
                    .shadow(radius: 2, y:1)
                    .disableAutocorrection(true)
                Button {
                    idNotOverlaped.toggle()
                } label: {
                    Text(idNotOverlapedColor ? "확인완료" : "중복확인")
                        .foregroundColor(.white)
                        .padding(3)
                    
                }
                .alert("사용 가능한 아이디입니다", isPresented: $idNotOverlaped) {
                    Button("확인", role: .cancel) {
                        idNotOverlapedColor = true
                    }
                }
                .padding(.horizontal, 7)
                .padding(.vertical, 4)
                .background(idNotOverlapedColor ? Color.green : Color.black)
                .cornerRadius(5)
                
            }
        }
        .padding(.bottom)
    }
}

struct NameInputs: View {
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("이름")
                .bold()
            HStack {
                TextField("이름", text: $loginSignupStore.name)
                    .shadow(radius: 2, y: 1)
                .disableAutocorrection(true)
                
                Button {
                    loginSignupStore.name = ""
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }

            }
        }
        .padding(.bottom)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(dissmissStart: .constant(false))
            .environmentObject(LoginSignupStore())
    }
}
