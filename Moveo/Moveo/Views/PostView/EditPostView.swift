//
//  AddPostView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import SwiftUI
import Firebase
import FirebaseStorage


struct EditPostView: View {
    // dismiss를 사용하기 위해 필요
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    
    // imagePicker를 사용하기 위해 필요
    @State private var imagePickerSelected: Bool = false
    @State var image: UIImage?
    
    @State private var categories: [String] = ["선택", "운동", "공부", "예술", "멘탈케어"]
    @State private var selectedCategory: String = ""
    
    @State var post: Post

    
    var body: some View {
        VStack {
            // MARK: - imagePicker
            Button {
                imagePickerSelected.toggle()
            } label: {
                if let image = self.postStore.postImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                } else {
                    ZStack {
                        Image(systemName: "camera")
                            .zIndex(1)
                            .font(.largeTitle)
                            .foregroundColor(.pointGray)
                        
                        Rectangle()
                            .stroke(Color.pointGray, lineWidth: 1)
                            .frame(width: 400, height: 330)
                    }
                }
            }
            .frame(width: 400, height: 330)
            
            Spacer()
            
            HStack {
                Spacer()
                
                // MARK: - categoryPicker
                Picker("카테고리를 선택해주세요", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            // MARK: - textEditor
            ZStack {
                TextEditor(text: $postStore.bodyText)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .frame(height: 200)
                
                if postStore.bodyText == "" {
                    Text("내용을 입력해주세요")
                        .opacity(0.5)
                        .offset(x: -100, y: -65)
                }
            }
            

            
            Spacer()
            Button {
                postStore.nickName = loginSignupStore.currentUserData?.nickName ?? ""
                postStore.profileImage = loginSignupStore.currentUserData?.profileImageUrl ?? ""
                postStore.postCategory = selectedCategory
                postStore.ImageToUpdate(post: post)
                dismiss()
            } label: {
                Text("수정하기")
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 330, height: 40)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .background {
                Color.mainColor
            }
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $imagePickerSelected) {
            ImagePicker(image: $postStore.postImage)
        }
        .onAppear{
            loginSignupStore.currentUserDataInput()
            postStore.fetchPosts()
        }
    }
}
