//
//  MainView.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/17.
//

import SwiftUI

struct MainView: View {
    
    // TODO: - 알림토글변수 추후 알림은 하나의 구조체로 묶어서 알림을 추가하면 생성되서 보여주도록 변경할 것
    @State private var alarmToggle1: Bool = true
    @State private var alarmToggle2: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경색 설정
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
                            // TODO: - 설정페이지 연결(알림에 대한 설정을 추가하게 된다면 사용 아니면 삭제)
                        } label: {
                            Image(systemName: "gearshape.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.mainColor)
                            
                        }
                        
                        NavigationLink {
                            // TODO: - 글쓰기 페이지에 연결
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.mainColor)
                        }
                    }
                    
                    // TODO: - 달력자리 추후 이미지 목업은 제거하고 기능으로 추가할 것
                    Image("roundFit")
                        .resizable()
                        .scaledToFit()
                    
                    // TODO: - 추후 알림은 하나의 구조체로 묶어서 알림을 추가하면 생성되서 보여주도록 변경할 것
                    HStack(alignment: .center) {
                        Text("오늘의 일정")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "plus.square")
                            .font(.title2)
                    }
                    .padding(.top, 20)
                    
                    ZStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(width: 353, height: 60)
                            .foregroundColor(.pointGray)
                            .cornerRadius(10)
                        
                        Toggle(isOn: $alarmToggle1) {
                            Text("07:00~08:30 운동")
                                .font(.title3)
                                .bold()
                        }
                        .toggleStyle(MyToggleStyle())
                        .zIndex(1)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    
                    ZStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(width: 353, height: 60)
                            .foregroundColor(.pointGray)
                            .cornerRadius(10)
                        
                        Toggle(isOn: $alarmToggle2) {
                            Text("19:00~21:00 알고리즘 공부")
                                .font(.title3)
                                .bold()
                        }
                        .toggleStyle(MyToggleStyle())
                        .zIndex(1)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

// TODO: - 추후 알림을 따로 구조체로 만들어서 분리 시 해당 구조체 안에 넣어서 하나의 기능으로 분류할 것
struct MyToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 40, height: 20)
                    .foregroundColor(configuration.isOn ? .mainColor : .white)
                
                ZStack {
                    Circle()
                        .fill(Color.pointGray)
                        .frame(width: 18)
                    
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 20)
                        .onTapGesture {
                            withAnimation {
                                configuration.$isOn.wrappedValue.toggle()
                            }
                        }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
