//
//  CategoryView.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/20.
//

import SwiftUI

struct CategoryView: View {
    @State var isSelected : [Bool] = [false, false, false, false, false]
    @EnvironmentObject var userStore : LoginSignupStore
    @Binding var dismissToRoot: Bool
    var body: some View {
        
            VStack {
                Spacer()
                    .frame(height: 40)
                VStack(alignment: .leading) {
                    Text("카테고리 선택하기")
                        .font(.largeTitle)
                        .padding(.bottom, 5)
                    Text("같은 카테고리를 선택한 사람들과 게시물을 공유하세요 :)")
                        .font(.headline)
                }
                Spacer()
                    
                VStack {
                    Button {
                        isSelected[0].toggle()
                    } label: {
                        Text("공부")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .background(isSelected[0] ? Color.mainColor : .gray)
                            .cornerRadius(20)
                    }
                    Button {
                        isSelected[1].toggle()
                    } label: {
                        Text("운동")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .background(isSelected[1] ? Color.mainColor : .gray)
                            .cornerRadius(20)
                    }
                    Button {
                        isSelected[2].toggle()
                    } label: {
                        Text("예술")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .background(isSelected[2] ? Color.mainColor : .gray)
                            .cornerRadius(20)
                    }
                    Button {
                        isSelected[3].toggle()
                    } label: {
                        Text("멘탈케어")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .background(isSelected[3] ? Color.mainColor : .gray)
                            .cornerRadius(20)
                    }
                    Button {
                        isSelected[4].toggle()
                    } label: {
                        Text("자기계발")
                            .bold()
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 50)
                            .background(isSelected[4] ? Color.mainColor : .gray)
                            .cornerRadius(20)
                    }
                }
                Spacer()
                    .frame(height: 130)
                
                
                    NavigationLink(destination: SignUpView(dissmissStart: $dismissToRoot)) {
                        Text("회원가입")
                    }
                    .isDetailLink(false)
                

                
                Spacer()
                    .frame(height: 70)

        }
            .onDisappear {
                appendCategories(isSelected: isSelected)
                print(userStore.selectedCategories)
            }
    }
        
    func appendCategories(isSelected : [Bool]) {
        userStore.selectedCategories = []
        if isSelected[0] == true {
            userStore.selectedCategories.append("공부")
        }
        if isSelected[1] == true {
            userStore.selectedCategories.append("운동")
        }
        if isSelected[2] == true {
            userStore.selectedCategories.append("예술")
        }
        if isSelected[3] == true {
            userStore.selectedCategories.append("멘탈케어")
        }
        if isSelected[4] == true {
            userStore.selectedCategories.append("자기계발")
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(dismissToRoot: .constant(false))
    }
}
