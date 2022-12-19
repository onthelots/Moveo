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
                                .cornerRadius(10)
                        }
                        .shadow(radius: 5)
                    })
                }
                .padding(.horizontal, 15)
                
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

struct CardView: View {
    @EnvironmentObject var postStore: PostStore
    var post: Post
    
    var body: some View {
        ZStack {
            VStack {
                WebImage(url: URL(string: post.postImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 330, height: 370, alignment: .center)
                    .clipped()
                
                ZStack {
                    Text(post.bodyText)
                        .zIndex(1)
                    
                    Rectangle()
                        .frame(width: 330, height: 80)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(PostStore())
    }
}
