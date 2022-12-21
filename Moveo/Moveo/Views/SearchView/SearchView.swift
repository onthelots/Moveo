//
//  SerchView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var postStore: PostStore
    @State private var cardScale: Bool = true
    @State private var cardScale1: Bool = true
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State private var searchText: String = ""
    
    // MARK: 현재 카테고리 이름
    @State private var currentCategory: String = "공부"
    
    // MARK: sheet toggle
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // MARK: - 뷰가 위로 넘어가는 것을 방지하기 위한 rectangle
                    Rectangle()
                        .fill(Color.backgroundColor)
                        .frame(height: 1)
                    
                    // MARK: - 검색창
                    Label {
                        TextField("Search...", text: $searchText)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    } icon : {
                        Image(systemName: "magnifyingglass")
                            .font(.callout)
                            .fontWeight(.light)
                            .padding(.leading, 5)
                    }
                    .frame(width: 345, height: 40)
                    .background(.gray)
                    .opacity(0.3)
                    .cornerRadius(10)
                    
                    ScrollView(showsIndicators: false, content: {

                        // MARK: - 카테고리
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                
//                                Button {
//                                    currentCategory = "전체"
//                                } label: {
//                                    Image("searchCategory0")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 50)
//                                }
                                
                                Button {
                                    currentCategory = "공부"
                                } label: {
                                    Image("searchCategory2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                
                                Button {
                                    currentCategory = "운동"
                                } label: {
                                    Image("searchCategory1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                
                                Button {
                                    currentCategory = "예술"
                                } label: {
                                    Image("searchCategory3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                
                                Button {
                                    currentCategory = "멘탈케어"
                                } label: {
                                    Image("searchCategory5")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                
                                Button {
                                    currentCategory = "자기계발"
                                } label: {
                                    Image("searchCategory4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                }
                                
                            }
                        }
                        .padding(.vertical, 10)
                        
                        Divider()
 
                        // TODO: - 추후 피드들 넣을 스크롤뷰, 현재 카드형태로 넣을 예정
                        VStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(postStore.posts) { post in
                                    
                                    // MARK: 카테고리별로 view 바뀜
                                    if (post.postCategory == currentCategory) {
                                        Button {
                                            showSheet.toggle()
                                        } label: {
                                            SearchCardView(post: post, searchText: searchText)
                                        }
                                        .sheet(isPresented: $showSheet) {
                                            SearchCardDetailView(selectedCard: post)
                                        }
                                    }
//                                    else if (currentCategory == "전체") {
//                                        Button {
//                                            showSheet.toggle()
//                                        } label: {
//                                            SearchCardView(post: post, searchText: searchText)
//                                        }
//                                        .sheet(isPresented: $showSheet) {
//                                            SearchCardDetailView(selectedCard: post)
//                                        }
//                                    }
                                }
                            }
                        }
                    })
                }
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear {
            postStore.fetchPosts()
//            postStore.getUsersNickName()
        }
        .refreshable {
            postStore.fetchPosts()
//            postStore.getUsersNickName()
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(PostStore())
    }
}
