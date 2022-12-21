//
//  OtherPersonProfileView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
// MARK: - 21일 오전 10시 40분 새로 추가된 뷰
struct OtherPersonProfileView: View {
    
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @EnvironmentObject var postStore : PostStore
    
    var columns : [GridItem] = Array(repeating: GridItem(.flexible(), spacing: nil, alignment: nil), count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    Text(loginSignupStore.postUserData?.nickName ?? "")
                        .font(.title2)
                        .bold()
                    
                    ScrollView {
                        VStack {
                            HStack(spacing: 50) {
                                WebImage(url: URL(string: loginSignupStore.postUserData?.profileImageUrl ?? ""))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                OtherPersonFollowers(text1: "4", text2: "게시물")
                                OtherPersonFollowers(text1: "110", text2: "팔로우")
                                OtherPersonFollowers(text1: "120", text2: "팔로잉")
                            }
                            .padding(10)
                            
                            Text(loginSignupStore.postUserData?.description ?? "")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(loginSignupStore.postUserData?.category ?? [], id: \.self) { category in
                                        Text(category)
                                            .padding()
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .background { Color.mainColor }
                                            .cornerRadius(50)
                                    }
                                }
                                .padding(.leading, 20)
                            }
                            
                            Divider()
                            
                        }
                    }
                }
            }
        }
        .onAppear{
            postStore.fetchPosts()
        }
    }
}

struct OtherPersonFollowers : View {
    var text1 : String
    var text2 : String
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(text1)
                .font(.system(size: 16, weight: .semibold))
            Text(text2)
                .font(.system(size: 15))
        }
    }
}

struct OtherPersonPost : View {
    var post : Post
    var body: some View {
        WebImage(url: URL(string: post.postImageUrl))
            .resizable()
            .frame(width: 173, height: 173)
            .scaledToFit()
            .cornerRadius(10)
    }
}

struct OtherPersonProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherPersonProfileView()
            .environmentObject(LoginSignupStore())
            .environmentObject(PostStore())
    }
}
