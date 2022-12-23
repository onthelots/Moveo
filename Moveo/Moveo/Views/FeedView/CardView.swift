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
                                else{
                                    Text("404 Error")
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
                                        .foregroundColor(Color.red)
                                        .font(.title2)
                                    
                                } else {
                                    Image(systemName: "heart")
                                        .foregroundColor(Color.black)
                                        .font(.title2)
                                }
                            }
                            
                            NavigationLink(destination: {
                                CommentView(post: post)
                            }, label: {
                                Image(systemName: "message")
                                    .font(.title3)
                                    .foregroundColor(.black)
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
                checkBookmarked()
                likeToggle = likeStore.currentUserLikedFetch(currentUid: loginSignupStore.currentUserData?.id ?? "", post: post)
                
                print(likeStore.currentUserLikedFetch(currentUid: loginSignupStore.currentUserData?.id ?? "", post: post))
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
    
    //    func checkLiked() {
    //        if let currentUser = loginSignupStore.currentUserData {
    //            let postID = post.id
    //        }
    //    }
}

//struct CardView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CardView(, post: <#Post#>)
//            .environmentObject(PostStore())
//            .environmentObject(LoginSignupStore())
//    }
//}
