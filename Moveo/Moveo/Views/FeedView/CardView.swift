//
//  CardView.swift
//  Moveo
//
//  Created by 기태욱 on 2022/12/20.
//

import SwiftUI
import SDWebImageSwiftUI


struct CardView: View {
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var loginSignupStore : LoginSignupStore
    @EnvironmentObject var likeStore: LikeStore
    
    
    @State private var likeToggle = true
    @State private var markToggle = true
    @State private var tag: Int? = nil
    // Modal
    @State private var showModal : Bool = false
    
    //alert
    @State private var showingAlert = false
    
    
    var post: Post
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack {
                    VStack{
                        HStack {
                            ZStack {
                                NavigationLink(destination: OtherPersonProfileView(), tag: 1, selection: self.$tag) {
                                    Text(".")
                                }
                                
                                Button {
                                    loginSignupStore.postWriterUserDataInput(post: post)
                                    print("포스트 유저 닉네임: \(loginSignupStore.postUserData?.nickName ?? "")")
                                    self.tag = 1
                                } label: {
                                    HStack {
                                        if post.profileImage != "" {
                                            WebImage(url: URL(string: post.profileImage))
                                                .resizable()
                                                .cornerRadius(25)
                                                .frame(width: 50, height: 50)
                                        } else {
                                            Image(systemName: "person.circle")
                                                .font(.system(size: 50))
                                                .foregroundColor(Color(.label))
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(post.nickName)
                                                .font(.body)
                                                .fontWeight(.medium)
                                                .foregroundColor(.black)
                                            
                                            Text(post.postDate)
                                                .font(.caption2)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            
                            // MARK: - EditPost(포스트 수정) 화면으로 전환
                            NavigationLink {
                                if (loginSignupStore.currentUserData?.id ?? "" == post.writerUid)
                                {
                                    EditPostView(post : post)
                                    
                                }
                                else {
                                    Text("접근 권한이 없습니다")
                                    // 다른 계정에 접근했을 때 뭔가 경고창이나 알림메세지 같은 걸로 하면 좋을 것 같아요, 시도해보겠습니다
                                    
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing, 5)
                            
                            
                            Button {
                                
                                markToggle.toggle()
                                //TO DO : 북마크 클릭시 액션
                                if !markToggle {
                                    loginSignupStore.currentUserData?.bookmark.append(post.id)
                                    //print(loginSignupStore.currentUserData?.bookmark)
                                } else {
                                    loginSignupStore.currentUserData?.bookmark.remove(at: (loginSignupStore.currentUserData?.bookmark.firstIndex(of: post.id)!)!)
                                    //print(loginSignupStore.currentUserData?.bookmark)
                                }
                                loginSignupStore.uploadBookmarkedPost(selectedPostId: post.id)
                            } label: {
                                if markToggle {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(Color.gray)
                                } else {
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(Color.mainColor)
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.bottom, 5)
                    }
                    
                    WebImage(url: URL(string: post.postImageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 360, height: 370, alignment: .center)
                        .clipped()
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading){
                        Text(post.bodyText)
                            .frame(width: 350, alignment: .leading)
                        
                        //TO DO : 글자가 길어질 시 '더보기' 하면 전문이 보이도록 하는 기능 구현
                        
                    }
                    .frame(width: 360, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                    
                    
                    HStack{
                        HStack {
                            Button {
                                if likeToggle {
                                    likeStore.deleteLike(post: post, currentUid: loginSignupStore.currentUserData?.id ?? "")
                                    
                                    likeToggle.toggle()
                                } else {
                                    likeStore.addLike(post: post, currentUid: loginSignupStore.currentUserData?.id ?? "", currentNickName: loginSignupStore.currentUserData?.nickName ?? "", currentProfileImage: loginSignupStore.currentUserData?.profileImageUrl ?? "")
                                    
                                    likeToggle.toggle()
                                }
                                //likeStore.fetchLikes(post: post)
                                
                            } label: {
                                if likeToggle {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(Color.black)
                                    
                                } else {
                                    Image(systemName: "heart")
                                        .foregroundColor(Color.red)
                                }
                            }
                            
                            Text("1.1k")
                                .font(.caption2)
                                .fontWeight(.light)
                            
                            NavigationLink(destination: {
                                CommentView(post: post)
                            }, label: {
                                Image(systemName: "message")
                                    .font(.title3)
                            })
                            
                            //TO DO : comment의 사용자 id를 카운트 해서 반영
                            
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    Divider()
                        .padding()
                }
            }
            .onAppear {
                likeToggle = likeStore.currentUserLikedFetch(currentUid: loginSignupStore.currentUserData?.id ?? "", post: post)
                loginSignupStore.fetchUser()
                loginSignupStore.fetchCurrentUser()
                checkBookmarked()
                likeStore.fetchLikes(post: post)
                postStore.fetchPosts()
            }
            
        }
    }
    // 앱을 껐다 켰을 때 북마크가 되어있던 포스트인지 체크
    func checkBookmarked() {
        if let currentUser = loginSignupStore.currentUserData {
            if currentUser.bookmark.contains(post.id) {
                self.markToggle = false
            }
        }
    }
}
