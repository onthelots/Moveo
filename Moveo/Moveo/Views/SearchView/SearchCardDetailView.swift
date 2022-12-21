//
//  SearchCardDetailView.swift
//  Moveo
//
//  Created by 전근섭 on 2022/12/21.
//

import SwiftUI

struct SearchCardDetailView: View {
    
    @EnvironmentObject var postStore: PostStore
    @EnvironmentObject var loginSignupStore : LoginSignupStore
    
    var selectedCard: Post
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(postStore.posts) { post in
                        // MARK: SearchCardView에서 선택된 user의 게시물만 보여줌
                        if post.nickName == selectedCard.nickName {
                            CardView(post: post)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SearchCardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardDetailView(selectedCard: PostStore().posts[0])
            .environmentObject(PostStore())
            .environmentObject(LoginSignupStore())
    }
}
