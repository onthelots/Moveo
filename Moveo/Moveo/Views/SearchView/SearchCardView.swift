//
//  SearchCardView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/20.
//

import SwiftUI
import SDWebImageSwiftUI


struct SearchCardView: View {
    @EnvironmentObject var postStore: PostStore
    
    @Binding var ScrollViewOffset: CGFloat
    @Binding var StartOffset: CGFloat
    
    var post: Post
    var searchText: String
    
    var body: some View {
        VStack {
            // MARK: 검색 조건
            if (searchText == "") || (post.nickName.contains(searchText)) {
                WebImage(url: URL(string: post.postImageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 180, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
            }
        }
        .overlay(
            GeometryReader { proxy -> Color in
                    DispatchQueue.main.async {
                        if StartOffset == 0 {
                            self.StartOffset = proxy.frame(in: .global).minY
                        }
                        let offset = proxy.frame(in: .global).minY
                        self.ScrollViewOffset = offset - StartOffset
                        
                        print(self.ScrollViewOffset)
                    }
                    return Color.clear
                }
                .frame(width: 0, height: 0)
                ,alignment: .top
        )
    }
}


struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(ScrollViewOffset: .constant(0), StartOffset: .constant(0), post: PostStore().posts[0], searchText: "")
            .environmentObject(PostStore())
    }
}
