//
//  ProfileView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
// TODO: - 형태는 유지하되 전체적으로 데이터를 받아와서 보여줄 수 있도록 할 것
struct OtherPersonProfileView: View {
    
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @EnvironmentObject var postStore : PostStore
    @EnvironmentObject var followingStore : FollowStore
    
    @State var isSelected = 0
    
    @State var myToggle: Bool = true
    @State var bookToggle: Bool = false
    @State var menuXAxis: Double = -90
    
    @State private var isSelectedMenu: Bool = false
    
    var columns : [GridItem] = Array(repeating: GridItem(.flexible(), spacing: nil, alignment: nil), count: 2)
    // 내 포스트와 북마크된 포스트들의 배열
    @State var bookMarkedPosts : [Post] = []
    @State var myPosts : [Post] = []
    // Motivators에 나를 제외한 유저들을 보여줌
    @State var usersExceptMe : [User] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
//                    HStack(spacing: 15) {
//                        Text(loginSignupStore.postUserData?.nickName ?? "")
//                            .font(.title2)
//                            .bold()
//
//                        Spacer()
//
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, 10)
                    
                    ScrollView {
                        VStack {
                            HStack(spacing: 50) {
                                WebImage(url: URL(string: loginSignupStore.postUserData?.profileImageUrl ?? ""))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                Followers(text1: "\(self.countMyPosts())", text2: "게시물")
                                Followers(text1: "\(followingStore.followers.count)", text2: "팔로워")
                                Followers(text1: "\(followingStore.followings.count)", text2: "팔로잉")
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
                                            .font(.caption)
                                            .frame(width: 80, height: 30)
                                            .foregroundColor(.white)
                                            .background { Color.mainColor }
                                            .cornerRadius(50)
                                            .onTapGesture {
                                                fetchMyPosts(category: category)
                                            }
                                    }
                                    Image(systemName: "plus.circle.fill")
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                        .font(.title)
                                }
                            }
                            Divider()
                        }
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                                    LazyVGrid(columns: columns) {
                                        ForEach(myPosts) { post in
                                            MyPost(post: post)
                                        }
                                    }
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                        }
                    }
                }
            }
        }
        .navigationTitle(loginSignupStore.postUserData?.nickName ?? "")
        .onAppear{
            postStore.fetchPosts()
            loginSignupStore.fetchUser()
            followingStore.fetchFollowing()
            followingStore.fetchFollower()
            fetchMyPosts(category: loginSignupStore.currentUserData?.category[0] ?? "")
            fetchUserExceptMe()
        }
    }
    
    // 위 bookMarkedPosts 배열에 북마크된 포스트들만 담아주는 배열
    func makeBookMarkedPosts() {
        self.bookMarkedPosts = []
        guard let currentUser = loginSignupStore.currentUserData else { return }
        print("loginSignupStore.bookmark : \(loginSignupStore.currentUserData!.bookmark)")
        print("postStore.posts : \(postStore.posts)")
        for post in postStore.posts {
            if currentUser.bookmark.contains(post.id) {
                bookMarkedPosts.append(post)
            }
        }
        
        print("bookMarkedPosts : \(bookMarkedPosts)")
    }
    
    func fetchMyPosts(category : String) {
        self.myPosts = []
        guard let currentUser = loginSignupStore.currentUserData else { return }
        
        for post in postStore.posts {
            if post.writerUid == currentUser.id {
                if post.postCategory == category {
                    myPosts.append(post)
                }
            }
        }
    }
    
    func countMyPosts() -> Int {
        var count = 0
        guard let currentUser = loginSignupStore.currentUserData else { return 0 }
        for post in postStore.posts {
            if post.writerUid == currentUser.id {
                count += 1
            }
        }
        return count
    }
    
    func fetchUserExceptMe() {
        self.usersExceptMe = []
        guard let currentUser = loginSignupStore.currentUserData else { return }
        for user in loginSignupStore.users {
            if user.id != currentUser.id {
                usersExceptMe.append(user)
            }
        }
    }
}


struct OtherPersonProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherPersonProfileView()
            .environmentObject(LoginSignupStore())
            .environmentObject(PostStore())
            .environmentObject(FollowStore())
    }
}
