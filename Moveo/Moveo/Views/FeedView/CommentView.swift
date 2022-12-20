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
    
    @State var selectedPost: Post
    @State private var showModal: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if userStore.findPostProfileImageUrlString(selectedPost: selectedPost) != "" {
                        WebImage(url: URL(string: userStore.findPostProfileImageUrlString(selectedPost: selectedPost)))
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
                            Text(userStore.findPostNickname(selectedPost: selectedPost))
                                .padding(.trailing, 5)
                            Text(selectedPost.bodyText)
                        }
                        Text(selectedPost.postDate)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                ForEach(commentStore.comments) { comment in
                    CommentCell(comment: comment)
                        .padding(.bottom)
                }
                
                Spacer()
            }
            .zIndex(1)
            
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
        }
        .onAppear {
            commentStore.postId = selectedPost.id
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
        CommentView(selectedPost: PostStore().posts[0])
            .environmentObject(LoginSignupStore())
            .environmentObject(CommentStore())
    }
}

struct CommentCell: View {
    @EnvironmentObject var userStore: LoginSignupStore
    @State private var userImage: UIImage? = nil
    @State var comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack {
                    if userStore.findCommentProfileImageUrlString(comment: comment) != "" {
                        WebImage(url: URL(string: userStore.findCommentProfileImageUrlString(comment: comment)))
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
                        Text(userStore.findCommentNickname(comment: comment))
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
                if userStore.currentUserImageUrlString() != "" {
                    WebImage(url: URL(string: userStore.currentUserImageUrlString()))
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
    }
}
