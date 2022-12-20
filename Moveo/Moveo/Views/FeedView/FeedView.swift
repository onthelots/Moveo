//
//  FeedView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedView: View {
    @EnvironmentObject var postStore: PostStore
    @State private var cardScale: Bool = true
    @State private var cardScale1: Bool = true
    @State private var cardWidth: CGFloat = 160
    @State private var cardHeight: CGFloat = 240
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Image("moveoLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        
                        Spacer()
                        
                        NavigationLink {
                            // TODO: - 글쓰기 페이지에 연결
                            AddPostView()
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.mainColor)
                        }
                    }
                    
                    Divider()
                    
                    
                    
                    // TODO: - 추후 피드들 넣을 스크롤뷰, 현재 카드형태로 넣을 예정
                    ScrollView(showsIndicators: false, content: {
                        ForEach(postStore.posts) { post in
                            CardView(post: post)
                                
                        }
                        
                    })
                }
                
            }
        }
        .onAppear {
            postStore.fetchPosts()
        }
        .refreshable {
            postStore.fetchPosts()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(PostStore())
    }
}
