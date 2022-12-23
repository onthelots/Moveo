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
    
    // MARK: 현재 카테고리 이름, Array
    @State private var currentCategory: String = "공부"
    @State private var CategoryArr: [String] = ["공부", "운동", "예술", "멘탈케어", "자기개발"]
    
    // MARK: sheet toggle
    @State private var showSheet: Bool = false
    
    
    @State private var ScrollViewOffset: CGFloat = 0
    @State private var StartOffset: CGFloat = 0
    
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
                    
                    ScrollViewReader { proxyReader in
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
                                        Text("공부")
                                            .bold()
                                            .padding(8)
                                            .background(currentCategory == "공부" ? Color.black : Color.pointGray)
                                            .cornerRadius(10)
                                    }
                                    
                                    Button {
                                        currentCategory = "운동"
                                    } label: {
                                        Text("운동")
                                            .bold()
                                            .padding(8)
                                            .background(currentCategory == "운동" ? Color.black : Color.pointGray)
                                            .cornerRadius(10)
                                    }
                                    
                                    Button {
                                        currentCategory = "예술"
                                    } label: {
                                        Text("예술")
                                            .bold()
                                            .padding(8)
                                            .background(currentCategory == "예술" ? Color.black : Color.pointGray)
                                            .cornerRadius(10)
                                    }
                                    
                                    Button {
                                        currentCategory = "멘탈케어"
                                    } label: {
                                        Text("멘탈케어")
                                            .bold()
                                            .padding(8)
                                            .background(currentCategory == "멘탈케어" ? Color.black : Color.pointGray)
                                            .cornerRadius(10)
                                    }
                                    
                                    Button {
                                        currentCategory = "자기개발"
                                    } label: {
                                        Text("자기개발")
                                            .bold()
                                            .padding(8)
                                            .background(currentCategory == "자기개발" ? Color.black : Color.pointGray)
                                            .cornerRadius(10)
                                    }
                                    
                                }
                            }
                            .padding(.vertical, 5)
                            
                            
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
                                                SearchCardView(ScrollViewOffset: $ScrollViewOffset, StartOffset: $StartOffset, post: post, searchText: searchText)
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
                            .id("Scroll_To_Top")
                        })
                        .overlay(
                            
                            Button {
                                withAnimation(.default) {
                                    // ScrollViewReader의 proxyReader을 넣어줌
                                    proxyReader.scrollTo("Scroll_To_Top", anchor: .top)
                                }
                            } label: {
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.mainColor)
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            }
                            
                            ,alignment: .bottomTrailing
                        )
                    }
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
