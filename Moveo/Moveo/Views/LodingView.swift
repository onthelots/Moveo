//
//  LodingView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

struct LodingView: View {
    @State private var handWidth: CGFloat = 20
    @State private var handOpacity: CGFloat = 0
    
    @State private var firstStringX: Double = -48
    //@State private var firstStringDegree: Double = 20
    
    @State private var lastStringX: Double = 55
    
    @State private var crushOpacity: CGFloat = 0
    
    @State private var moveoY: CGFloat = -600
    @State private var moveoDegree: Double = 30
    
    var body: some View {
        ZStack {
            Image("moveo")
                .resizable()
                .scaledToFit()
                .frame(width: 330)
                .rotationEffect(Angle(degrees: moveoDegree), anchor: .bottomTrailing)
                .offset(y: moveoY)
                .zIndex(2)
            
            Image("hand")
                .resizable()
                .scaledToFit()
                .frame(width: handWidth)
                .offset(x: 2,y: -9)
                .opacity(handOpacity)
                .zIndex(3)
            
            Image("firstString")
                .resizable()
                .scaledToFit()
                .frame(width: 110)
                .offset(x: firstStringX)
                //.rotationEffect(Angle(degrees: firstStringX), anchor: .leading)
                .zIndex(2)
            
            Image("lastString")
                .resizable()
                .scaledToFit()
                .frame(width: 107)
                .offset(x: lastStringX)
                .zIndex(2)
            
            Image("crush")
                .resizable()
                .scaledToFit()
                .frame(width: 320)
                .offset(x: -4,y: -34)
                .opacity(crushOpacity)
                .zIndex(1)
            
            Image("rightPoint")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .offset(x: 173, y: -128)
                .opacity(0)
            
            Image("leftPoint")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .offset(x: -150, y: -20)
                .opacity(0)
            
            Image("yellowStar")
                .resizable()
                .scaledToFit()
                .frame(width: 17)
                .offset(x: -162, y: -155)
                .opacity(0)
            
            Image("yellowStar")
                .resizable()
                .scaledToFit()
                .frame(width: 17)
                .offset(x: 153, y: -30)
                .opacity(0)
                .zIndex(3)
            
            Image("whiteStar")
                .resizable()
                .scaledToFit()
                .frame(width: 16)
                .offset(x: -175, y: -132)
                .opacity(0)
            
            //            Image("mainLogo")
            //                .resizable()
            //                .scaledToFit()
            //                .zIndex(4)
            //                .offset(x: 4,y: -33)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                handOpacity = 1
                
                withAnimation(.linear(duration: 0.3)) {
                    handWidth = 90
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        firstStringX = -80
                        //firstStringDegree = 20
                        lastStringX = 87
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    crushOpacity = 1
                    withAnimation(.easeIn(duration: 0.4)) {
                        moveoY = -93
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        moveoDegree = 0
                    }
                }
            }
        }
    }
}

struct LodingView_Previews: PreviewProvider {
    static var previews: some View {
        LodingView()
    }
}
