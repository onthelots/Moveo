//
//  ContentView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

extension Color{
    static let mainColor = Color("mainColor")
    static let backgroundColor = Color("backgroundColor")
    static let pointGray = Color("pointGray")
}

struct ContentView: View {
    @EnvironmentObject var viewStore: ViewStore
    var body: some View {
        if viewStore.currentLoginCheckViewChanger {
            LodingAndLoginView()
        } else {
            ContainTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewStore())
    }
}
