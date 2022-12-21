//
//  ProfileView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/21.
//

import SwiftUI
import SDWebImageSwiftUI
// TODO: - 형태는 유지하되 전체적으로 데이터를 받아와서 보여줄 수 있도록 할 것
struct ProfileView: View {
    
    @EnvironmentObject var loginSignupStore: LoginSignupStore
    @EnvironmentObject var postStore : PostStore
    
    @State var isExpanded = false
    @State var subviewHeight : CGFloat = 0
    @State var motiDegree : CGFloat = 90
    @State var judgeMoti : Bool = false
    
    @State var isSelected = 0
    
    @State var myToggle: Bool = true
    @State var bookToggle: Bool = false
    @State var menuXAxis: Double = -90
    
    @State private var isSelectedMenu: Bool = false
    
    var columns : [GridItem] = Array(repeating: GridItem(.flexible(), spacing: nil, alignment: nil), count: 2)
    @State var bookMarkedPosts : [Post] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack(spacing: 15) {
                        Text(loginSignupStore.currentUserData?.nickName ?? "")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: {
                            Text("보관함")
                        }, label: {
                            Image(systemName: "tray.full")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                        })
                        
                        Button {
                            isSelectedMenu.toggle()
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                                .bold()
                        }
                        
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .confirmationDialog("메뉴", isPresented: $isSelectedMenu) {
                        Button("로그아웃", role: .destructive) {
                            loginSignupStore.logout()
                        }
                    }
                    
                    ScrollView {
                        VStack {
                            HStack(spacing: 50) {
                                WebImage(url: URL(string: loginSignupStore.currentUserData?.profileImageUrl ?? ""))
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                Followers(text1: "4", text2: "게시물")
                                Followers(text1: "110", text2: "멘토")
                                Followers(text1: "120", text2: "멘티")
                            }
                            .padding(10)
                            
                            Text(loginSignupStore.currentUserData?.description ?? "")
                                .font(.system(size: 15, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                            //.padding(.bottom)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(loginSignupStore.currentUserData?.category ?? [], id: \.self) { category in
                                        Text(category)
                                            .padding()
                                            .font(.system(size: 25))
                                            .foregroundColor(.white)
                                            .background { Color.mainColor }
                                            .cornerRadius(50)
                                    }
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.gray)
                                        .opacity(0.5)
                                        .font(.system(size: 25))
                                }
                                .padding(.leading, 20)
                            }
                            //                .padding(.bottom)
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Motivators")
                                        .font(.system(size: 15, weight: .bold))
                                        .padding(.leading, 10)
                                    
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .font(.system(size: 15, weight: .bold))
                                        .rotationEffect(Angle(degrees: motiDegree))
                                }
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.25)) {
                                        isExpanded.toggle()
                                        judgeMoti.toggle()
                                        if judgeMoti {
                                            self.motiDegree = 0
                                        } else{
                                            self.motiDegree = 90
                                            
                                        }
                                    }
                                }
                                .padding(.leading)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        Motivators(imageName: "profileViewSon", name: "Sonny__")
                                            .padding(.leading)
                                        Motivators(imageName: "profileViewElon", name: "@elonmusk")
                                        Motivators(imageName: "profileViewKim", name: "Queen_kr")
                                        Motivators(imageName: "profileViewKang", name: "Legend_B")
                                        Motivators(imageName: "profileViewSon", name: "Sonny__")
                                            .padding(.leading)
                                        Motivators(imageName: "profileViewElon", name: "@elonmusk")
                                        Motivators(imageName: "profileViewKim", name: "Queen_kr")
                                        Motivators(imageName: "profileViewKang", name: "Legend_B")
                                    }
                                }
                            }
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewHeightKey.self,
                                                       value: $0.frame(in: .local).size.height)
                            })
                            .onPreferenceChange(ViewHeightKey.self) { subviewHeight = $0 }
                            .frame(height: isExpanded ? 15 : subviewHeight, alignment: .top)
                            .clipped()
                            .frame(maxWidth: .infinity)
                            .transition(.move(edge: .bottom))
                            
                            Divider()
                            
                        }
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header: Header(myToggle: $myToggle, bookToggle: $bookToggle, menuXAxis: $menuXAxis)) {
                                if myToggle {
                                    if isSelected == 0 {
                                        LazyVGrid(columns: columns) {
                                            //
                                        }
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                    } else {
                                        LazyVGrid(columns: columns) {
                                            //
                                        }
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                    }
                                    
                                    
                                } else {
                                    LazyVGrid(columns: columns) {
                                        ForEach(bookMarkedPosts) { post in
                                            MyPost(post: post)
                                        }
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            loginSignupStore.currentUserDataInput()
            postStore.fetchPosts()
            makeBookMarkedPosts()
        }
    }
    
    // 위 bookMarkedPosts 배열에 북마크된 포스트들만 담아주는 배열
    func makeBookMarkedPosts() {
        self.bookMarkedPosts = []
        
        for post in postStore.posts {
            if loginSignupStore.currentUserData!.bookmark.contains(post.id) {
                bookMarkedPosts.append(post)
            }
        }
        print("loginSignupStore.bookmark : \(loginSignupStore.currentUserData!.bookmark)")
        print("bookMarkedPosts : \(bookMarkedPosts)")
    }
}

// Sticky Header 치면 나옴
struct Header: View {
    @Binding var myToggle: Bool
    @Binding var bookToggle: Bool
    @Binding var menuXAxis: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.backgroundColor)
                .frame(height: 40)
            VStack {
                HStack {
                    Button {
                        myToggle = true
                        bookToggle = false
                        menuXAxis = -90
                    } label: {
                        Text("My")
                            .foregroundColor(myToggle ? .mainColor : .black)
                    }
                    
                    Spacer()
                    
                    Button {
                        bookToggle = true
                        myToggle = false
                        menuXAxis = 90
                    } label: {
                        Text("Bookmark")
                            .foregroundColor(bookToggle ? .mainColor : .black)
                    }
                }
                .padding(.leading, 95)
                .padding(.trailing, 65)
                
                Rectangle()
                    .fill(Color.mainColor)
                    .animation(.linear(duration: 0.2), value: menuXAxis)
                    .offset(x: menuXAxis)
                    .frame(width: 160, height: 5)
            }
        }
    }
}

struct Followers : View {
    var text1 : String
    var text2 : String
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(text1)
                .font(.system(size: 16, weight: .semibold))
            Text(text2)
                .font(.system(size: 15))
        }
    }
}

struct Motivators : View {
    var imageName : String
    var name : String
    var body: some View {
        VStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text(name)
                .font(.system(size: 13, weight: .semibold))
                .padding(.bottom, 1)
            Button {
                //
            } label: {
                Text("팔로우")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 50)
                    .background(Color("mainColor"))
                    .cornerRadius(50)
            }
        }
        .frame(width: 80, height: 110)
        
    }
}

struct MyPost : View {
    var post : Post
    var body: some View {
        WebImage(url: URL(string: post.postImageUrl))         .resizable()
            .frame(width: 173, height: 173)
            .scaledToFit()
            .cornerRadius(10)
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(LoginSignupStore())
            .environmentObject(PostStore())
    }
}
