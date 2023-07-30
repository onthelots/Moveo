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
                        
//                        Rectangle()
//                            .fill(Color.white)
//                            .frame(width: 400, height: 340)
//                            .cornerRadius(10)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 250, height: 250)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.top, 50)
            
            Spacer()
                .frame(height: 70)
            
            TextField(text: $loginSignupStore.description, axis: .vertical) {
                Text("자기소개를 해주세요 :)")
            }
            .padding(9)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
            .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                NavigationLink(destination: CategoryView(dismissToRoot: $dismissToRoot)) {
                    Text("다음")
                }
                .isDetailLink(false)
                .padding(.horizontal, 152)
                .padding(.vertical, 15)
                .foregroundColor(.white)
                .background(Color.mainColor)
                .cornerRadius(10)
            }
            
            Spacer()
                .frame(maxHeight: 50)
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
