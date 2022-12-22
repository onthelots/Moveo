//
//  CommentView.swift
//  PlantsAndPets
//
//  Created by 진준호 on 2022/12/14.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentView: View {
    @EnvironmentObject var commentStore: CommentStore
    @EnvironmentObject var userStore: LoginSignupStore
    
    @State var post: Post
    @State private var showModal: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if post.profileImage != "" {
                        WebImage(url: URL(string: post.profileImage))
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 30, height: 30)
                            .padding(.horizontal, 2)
                    } else {
                        Image(systemName: "person.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 2)
                    }

                    VStack(alignment: .leading) {
                        HStack {
                            Text(post.nickName)
                                .bold()
                                .padding(.trailing, 5)
                            Text(post.bodyText)
                        }
                        
                        Text(post.postDate)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                ForEach(commentStore.comments) { comment in
                    CommentCell(comment: comment)
                        .padding(.bottom, 5)
                }
                
                Spacer()
            }
            .zIndex(1)
            
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .zIndex(0)
        }
        .onAppear {
            commentStore.postId = post.id
            commentStore.fetchComments()
        }
        .sheet(isPresented: $showModal) {
            AddCommentModalView()
                .presentationDetents([.medium])
        }
        .onTapGesture {
            showModal.toggle()
        }
        .refreshable {
            commentStore.fetchComments()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(post: PostStore().posts[0])
            .environmentObject(CommentStore())
            .environmentObject(LoginSignupStore())
    }
}

struct CommentCell: View {
    @State var comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack {
                    if comment.profileImage != "" {
                        WebImage(url: URL(string: comment.profileImage))
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 30, height: 30)
                            .padding(.horizontal, 2)
                    } else {
                        Image(systemName: "person.circle")
                            .font(.system(size: 30))
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 2)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(comment.nickName)
                            .bold()
                        Text(comment.commentText)
                    }
                    
                    Text(comment.commentDate)
                }
                Spacer()
                Image(systemName: "heart")
            }
        }
        .padding(.horizontal)
    }
}

struct AddCommentModalView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var commentStore: CommentStore
    @EnvironmentObject var userStore: LoginSignupStore
    
    @State private var commentText: String = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 80, height: 6)
                .foregroundColor(.gray)
                .padding(.vertical, 5)
            
            HStack {
                if userStore.currentUserData?.profileImageUrl != "" {
                    WebImage(url: URL(string: userStore.currentUserData?.profileImageUrl ?? ""))
                        .resizable()
                        .cornerRadius(15)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 5)
                } else {
                    Image(systemName: "person.circle")
                        .font(.system(size: 30))
                        .padding(.horizontal, 5)
                }
            
                TextField("댓글을 입력해주세요", text: $commentStore.commentText)
                    .padding(.leading, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.gray, lineWidth: 2)
                            .frame(width: 290, height: 40)
                    }
                
                Button {
                    commentStore.addComment(currentNickName: userStore.currentUserData?.nickName ?? "", currentProfileImage: userStore.currentUserData?.profileImageUrl ?? "")
                    dismiss()
                } label: {
                    Text("게시")
                        .foregroundColor(.mainColor)
                }
                .padding(.horizontal, 5)
            }
            .padding(.horizontal, 5)
            
            Spacer()
        }
        .padding(.top, 5)
        .onDisappear{
            commentStore.fetchComments()
        }
    }
}
