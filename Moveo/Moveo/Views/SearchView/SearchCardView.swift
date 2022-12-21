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
    
    var post: Post
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: post.postImageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 180, alignment: .center)
                .clipped()
                .cornerRadius(10)
        }
    }
}


struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(post: PostStore().posts[0])
            .environmentObject(PostStore())
    }
}
