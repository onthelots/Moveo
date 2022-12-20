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
                TextField("닉네임", text: $loginSignupStore.nickName)
                    .shadow(radius: 2, y:1)
                    .padding(.bottom)
                    .disableAutocorrection(true)
                
                PassWordInputs()
                
                
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 50)
            
            Button {
                loginSignupStore.createNewAccount()
                self.dissmissStart = false
            } label: {
                Text("가입완료")
            }
            .padding(.horizontal, 152)
            .padding(.vertical, 15)
            .foregroundColor(.white)
            .background(Color.mainColor)
            .cornerRadius(10)
//            .disabled((loginSignupStore.signUpPw == loginSignupStore.signUpPwCheck) && (loginSignupStore.signUpPwCheck.count != 0) ? false : true)
            
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
                SecureField("비밀번호 입력", text: $loginSignupStore.signUpPw)
                    .shadow(radius: 2, y:1)
                    .disableAutocorrection(true)
            }
            
            
            Group {
                Text("비밀번호 확인")
                    .bold()
                SecureField("비밀번호 재입력", text: $loginSignupStore.signUpPwCheck)
                    .shadow(radius: 2, y:1)
                    .disableAutocorrection(true)
            }
            
            
            if (loginSignupStore.signUpPw == loginSignupStore.signUpPwCheck) && (loginSignupStore.signUpPwCheck.count != 0) {
                Text("비밀번호가 일치합니다")
                    .foregroundColor(.green)
            } else {
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
                TextField("email", text: $loginSignupStore.signUpEmail)
                    .shadow(radius: 2, y:1)
                    .disableAutocorrection(true)
                Button {
                    idNotOverlaped.toggle()
                } label: {
                    Text(idNotOverlapedColor ? "확인완료" : "중복확인")
                        .foregroundColor(.white)
                        .padding(3)
                    
                }
                .alert("아이디가 중복되지 않았습니다", isPresented: $idNotOverlaped) {
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
            TextField("이름", text: $loginSignupStore.name)
                .shadow(radius: 2, y: 1)
                .disableAutocorrection(true)
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
