//
//  ProfileImageSetupView.swift
//  PlantsAndPets
//
//  Created by 전근섭 on 2022/12/14.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageSetupView: View {
    
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @EnvironmentObject var postStore : PostStore
    
    @State private var profileImageSelected: Bool = false
    @State private var userImage: UIImage? = nil
    @Binding var dismissToRoot: Bool
    
    var body: some View {
        
        VStack {
            
            Button {
                profileImageSelected.toggle()
            } label: {
                if let image = self.loginSignupStore.profileImageUrl {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                    
                } else {
                    ZStack {
                        Image(systemName: "camera")
                            .zIndex(1)
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 400, height: 340)
                            .cornerRadius(10)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 3)
                            )
                    }
                }
            }
            .padding(.top, 50)
            
            Spacer()
                .frame(height: 70)
            
            TextField("자기소개를 해주세요 :)", text: $loginSignupStore.description, axis: .vertical)
                .padding()
                .shadow(radius: 2, y:1)
                .padding(.bottom)
                .disableAutocorrection(true)
            
            Spacer()
            
            Button {
                
            } label: {
                NavigationLink(destination: CategoryView(dismissToRoot: $dismissToRoot)) {
                    Text("회원가입")
                }
                .isDetailLink(false)
            }
        }
        .fullScreenCover(isPresented: $profileImageSelected) {
            ImagePicker(image: $loginSignupStore.profileImageUrl)
        }
        .navigationTitle("프로필 사진 설정")
        
    }
}

struct ProfileImageSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileImageSetupView(dismissToRoot: .constant(false))
                .environmentObject(LoginSignupStore())
                .environmentObject(PostStore())
        }
    }
}
