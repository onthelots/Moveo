//
//  File.swift
//  KavasoftCustomCalendar
//
//  Created by Jae hyuk Yim on 2022/12/21.
//

import Foundation

// Local에서 알림센터를 띄우기 위해 활용 (Setting)
import NotificationCenter

// 기본 알림기능을 활용하기 위한 프레임워크
import UserNotifications

// 쓰레드 게시 오류를 해소하기 위해 선언
@MainActor


/// NotificationManager에서 포함하고 있는 있는 메서드는 아래와 같음
/// 1. notificationCenter : 사용자가 입력하는 값을 저장
/// 2. isGranted : 알림 인증여부를 확인함
/// 3. pendingRequest : 사용자의 입력값을 담아내는 배열 -> 여기에 실질적으로 사용자 알림 데이터가 담겨져 있음

// MARK: - NotificationManager -> 알림에 대한 모든 기능(사용자 인증, 사용자 입력값 설정 및 저장, 포그라운드/백그라운드 알림 발생) 담당
class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    // 1. 알림 기능을 담당하는 인스턴스 [notificationCenter]
    let notificationCenter = UNUserNotificationCenter.current()
    
    // 2. 사용자 알림설정 인증여부 확인 -> 게시(Published) 프로퍼티
    @Published var isGranted: Bool = false
    
    // 3. [UNNotificationRequest]라는 사용자의 입력값을 담아내는 빈 배열을 만들어 줌 -> 게시(Published) 프로퍼티
    @Published var pendingRequests: [UNNotificationRequest] = []
    
    // 대리자 위임을 받아야함.. delegate
    override init () {
        super.init()
        notificationCenter.delegate = self
    }
    
    // MARK: - 사용자가 입력한 알람옵션을 반환하면서 띄어주는 메서드 -> getPendingRequest() 메서드를 통해 저장된 빈 배열(값)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        
        // 사용자가 입력하는 알림을 여기서 위임을 받아서 처리함 -> 알람 내용도 보여줘야 하니..
        await getPendingRequests()
        return [.sound, .banner]
    }
    
    
    //MARK: - 앱이 시작하기 전, 알림설정을 물어보는 메서드 -> 해당 requestAuthorization()을 특정 뷰에서 onAppear로 보여줌
    func requestAuthorization() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .badge, .alert])
        
        await getCurrentSetting()
    }
    
    
    // MARK: - 현재의 인증 상태를 확인하는 메서드
    func getCurrentSetting() async {
        
        // 현재의 인증현황을 확인하고
        let currentSetting = await notificationCenter.notificationSettings()
        
        // isGranted 프로퍼티에 현재 인증상태 값을 할당함 (거절을 눌렀다면 false, 동의를 눌렀으면 true로 변환되는걸 볼 수 있음)
        isGranted = (currentSetting.authorizationStatus == .authorized)
        print(isGranted)
    }
    
    // MARK: - 인증을 하지 않을 경우, 로컬에 옵션창을 열어줌
    func openSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
    
    
    // MARK: - 선언한 사용자 입력값(store)를 1.Content로 처리하고 / 2. Trigger로 설정하고 / 3. Request를 통해 Content + Trigger를 처리하고 / 4. Center 저장소로 이동
    func schedule(eventInfo: Event)  {
        
        // 1. content, 즉 알람창에서 보여줄 수 있는 정보(title, subtitle, soumd, badge 등)를 Event 구조체의 값으로 할당
        let content = UNMutableNotificationContent()
        
        content.title = eventInfo.note // title은 eventInfo에서의 note
        content.sound = .default  // sound는 default 값 (띵~)
        content.subtitle = eventInfo.eventType.rawValue // subtitle은 eventInfo에서 선언한 enum에서의 타입 기본값
        content.badge = 1 // badge는 일단 1로 할당함
        
        
        // 2. trigger = 사용자가 입력하는 schedule의 시간(dateMatching), 반복여부(repeats)를 선언함
        let trigger = UNCalendarNotificationTrigger(dateMatching: eventInfo.dateComponents, repeats: false)
        
        // 3. request = content(알림창에 저장할 사용자 정보) + triggeer(시간 및 반복여부) -> 2개를 저장하고, id값으로는 고유값을 설정
        let request = UNNotificationRequest(identifier: eventInfo.id, content: content, trigger: trigger)
    
        
        // 4. 마지막으로, notificationCenter (모든 정보가 담긴)에 request값을 add함
        notificationCenter.add(request)
        
    }
    
    // MARK: - pendingRequests 이름의 빈 배열에, notificationCenter에 저장된 값을 저장함
    func getPendingRequests() async {
        pendingRequests = await notificationCenter.pendingNotificationRequests()
        
        // 알림을 예약한 갯수(count)를 확인하기 위한 print
        print("Pending: \(pendingRequests.count)")
    }
    
    
    // MARK: - 사용자가 작성한 알림을 삭제하는 메서드
    func removeRequest(withIdentifier identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        // index 기능을 활용, 사용자 알림을 맨 첫번째 기능한 순서대로 제거함
        if let index = pendingRequests.firstIndex(where: {$0.identifier == identifier}) {
            pendingRequests.remove(at: index)
            print("Pending: \(pendingRequests.count)")
        }
        
    }
    
}
