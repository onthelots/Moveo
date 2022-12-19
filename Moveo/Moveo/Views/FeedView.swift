import SwiftUI

struct FeedView: View {
    @State private var cardScale: Bool = true
    @State private var cardScale1: Bool = true
    @State private var cardWidth: CGFloat = 160
    @State private var cardHeight: CGFloat = 240
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                        LazyVGrid(columns: columns, spacing: 20) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: cardScale ? 160 : 320, height: cardScale ? 240 : 480)
                                .foregroundColor(.mainColor)
                                .animation(.linear(duration: 0.2), value: cardScale)
                                .shadow(radius: 3, x: 3, y: 3)
                                .zIndex(cardScale ? 1 : 2)
                                .onTapGesture {
                                    cardScale.toggle()
                                }
                                //.scaleEffect(cardScale ? 1 : 2.1, anchor: .topLeading)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 160, height: 240)
                                .foregroundColor(.mainColor)
                                .scaleEffect(cardScale1 ? 1 : 2.1, anchor: .topTrailing)
                                .animation(.linear(duration: 0.2), value: cardScale1)
                                .shadow(radius: 3, x: 3, y: 3)
                                .zIndex(cardScale1 ? 1 : 2)
                                .onTapGesture {
                                    cardScale1.toggle()
                                }
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 160, height: 240)
                                .foregroundColor(.mainColor)
                                .shadow(radius: 3, x: 3, y: 3)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 160, height: 240)
                                .foregroundColor(.mainColor)
                                .shadow(radius: 3, x: 3, y: 3)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 160, height: 240)
                                .foregroundColor(.mainColor)
                                .shadow(radius: 3, x: 3, y: 3)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 160, height: 240)
                                .foregroundColor(.mainColor)
                                .shadow(radius: 3, x: 3, y: 3)
                        }
                    })
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
