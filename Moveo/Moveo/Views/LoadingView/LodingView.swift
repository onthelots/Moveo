//
//  LodingView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

struct LodingView: View {
    @EnvironmentObject var viewStore: ViewStore
    
    @State private var handScale: Bool = true
    
    @State private var firstStringX: Double = -73
    @State private var firstStringDegree: Double = 0
    
    @State private var lastStringX: Double = 73
    @State private var lastStringDegree: Double = 0
    
    @State private var crushOpacity: CGFloat = 0
    
    @State private var firstAniScale: Bool = true
    @State private var firstAniDegree: Double = 0
    
    @State private var logoOpacity: CGFloat = 0
    @State private var logoScale: Bool = true
    @State private var logoY: CGFloat = 0
    
    var body: some View {
        ZStack {
            ZStack {
                Image("hand")
                    .resizable()
                    .scaleEffect(handScale ? 0.01 : 0.33)
                    .scaledToFit()
                    .zIndex(3)
                
                Image("firstString")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .offset(x: firstStringX)
                    .rotation3DEffect(.degrees(firstStringDegree), axis: (x: 0, y: 1, z: 0),anchor: .leading)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 7), value: firstStringDegree)
                    .zIndex(2)
                
                Image("lastString")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .offset(x: lastStringX)
                    .rotation3DEffect(.degrees(lastStringDegree), axis: (x: 0, y: 1, z: 0),anchor: .trailing)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 7), value: lastStringDegree)
                    .zIndex(2)
                
                Image("crush")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .opacity(crushOpacity)
                    .offset(x: -6)
                    .zIndex(1)
            }
            .scaleEffect(firstAniScale ? 1 : 0)
            .rotationEffect(.degrees(firstAniDegree))
            
            ZStack {
                Image("mainLogo")
                    .resizable()
                    .scaledToFit()
                    .offset(y: logoY)
                    .opacity(logoOpacity)
                    .scaleEffect(logoScale ? 0 : 1)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 10), value: logoScale)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeIn(duration: 0.2)) {
                    handScale = false
                }
                withAnimation(.easeIn(duration: 0.5)) {
                    firstStringDegree = -30
                    lastStringDegree = 30
                    firstStringX = -110
                    lastStringX = 110
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                crushOpacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                withAnimation(.easeIn(duration: 0.8)) {
                    firstAniScale = false
                    firstAniDegree = 1080
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                logoOpacity = 1
                withAnimation(.easeIn(duration: 0.2)) {
                    logoScale = false
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                withAnimation(.easeOut(duration: 0.8)) {
                    logoY = -180
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.7) {
                viewStore.lodingViewChanger = false
            }
        }
        .padding(.horizontal, 20)
    }
}

struct LodingView_Previews: PreviewProvider {
    static var previews: some View {
        LodingView()
            .environmentObject(ViewStore())
    }
}
