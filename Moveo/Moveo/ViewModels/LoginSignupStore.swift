
//
//  LoginSignupStore.swift
//  Moveo
//
//  Created by 전근섭 on 2022/12/19.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

// MARK: LoginSignupStore
class LoginSignupStore: ObservableObject {
    // 로그인
    @Published var email: String = ""
    @Published var password: String = ""
    
    // 회원가입
    @Published var name: String = ""
    @Published var nickName: String = ""
    @Published var signUpEmail: String = ""
    @Published var signUpPw: String = ""
    @Published var signUpPwCheck: String = ""
    @Published var profileImageUrlString: String = "test"
//    @Published var users : [MyUser] = []
    
    // 프로필
    @Published var profileImageUrl: UIImage?
//    @Published var currentUserInfo: [MyUser] = []
    
    // 로그인 상태 확인
    @Published var currentUser: Firebase.User?
    
    // 화면전환 토글
    @Published var viewChangeToggle: Bool = false
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    // 로그인
    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user:", error)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.currentUser = result?.user
        }
    }
    
    // 로그아웃
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // 회원가입
    func createNewAccount() {
        // 프사 설정 해야만 회원가입 가능 코드
        //        if image == nil {
        //            loginstatusMessage = "You must select an avatar image"
        //            return
        //        }
        
        Auth.auth().createUser(withEmail: signUpEmail, password: signUpPw) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.storeUserInfoToDatabase(uid: result?.user.uid ?? "")
        }
    }
    
    // user 정보 database에 저장
//    func storeUserInfoToDatabase(uid: String) {
//
//        let uid = uid
//
//        let ref = Storage.storage().reference(withPath: uid)
//
//        guard let imageData = profileImageUrl?.jpegData(compressionQuality: 0.5) else {
//            return
//        }
//        ref.putData(imageData) { metadata, error in
//            if let error = error {
//                print("\(error)")
//                return
//            }
//            ref.downloadURL() { url, error in
//                if let error = error {
//                    print(error)
//                    return
//                }
//                print(url?.absoluteString ?? "망함")
//
//                guard let url = url else { return }
//
//                print(uid)
//                // model을 쓰면 쉽게 구조화할 수 있음
//                let userData = ["name" : self.name, "email" : self.signUpEmail, "uid" : uid, "profileImageUrl": url.absoluteString] as [String : Any]
//
//                Firestore.firestore().collection("users").document(uid).setData(userData as [String : Any]) { error in
//                    if let error = error {
//                        print(error)
//                        return
//                    }
//                    print("success")
//                }
//            }
//        }
//    }
    
    func storeUserInfoToDatabase(uid: String) {
        
        let uid = uid
        
        print(uid)
        // model을 쓰면 쉽게 구조화할 수 있음
        let userData = ["name" : name, "email" : signUpEmail, "uid" : uid]
        
        Firestore.firestore().collection("users").document(uid).setData(userData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
            print("success")
        }
    }
    
//    func fetchUser() {
//        Firestore.firestore().collection("users")
//            .getDocuments { (snapshot, error) in
//                self.users.removeAll()
//
//                if let snapshot {
//                    for document in snapshot.documents {
//
//                        let docData = document.data()
//                        // 있는지를 따져서 있으면 String으로 만들어줘, 없으면 ""로 만들자
//                        let id: String = docData["uid"] as? String ?? ""
//                        let name: String = docData["name"] as? String ?? ""
//                        let nickName: String = docData["nickName"] as? String ?? ""
//                        let email: String = docData["email"] as? String ?? ""
//                        let profileImageUrl: String = docData["profileImageUrl"] as? String ?? ""
//                        let user: MyUser = MyUser(id: id, nickName: nickName, email: email, name: name, profileImageUrl: profileImageUrl)
//
//                        self.users.append(user)
//                    }
//                }
//            }
//    }
    
//    func profileImageToStorage(selectedPost: Post) {
//        let uid = UUID().uuidString
//
//        let ref = Storage.storage().reference(withPath: uid)
//
//        guard let imageData = profileImageUrl?.jpegData(compressionQuality: 0.5) else {
//            return
//        }
//
//        ref.putData(imageData) { metadata, error in
//            if let error = error {
//                print("\(error)")
//                return
//            }
//
//            ref.downloadURL() { url, error in
//                if let error = error {
//                    print(error)
//                    return
//                }
//                print(url?.absoluteString ?? "망함")
//
//                guard let url = url else { return }
//
//                self.profileUpdate(profileImageUrl: url, selectedPost: selectedPost)
//            }
//        }
//    }
    
//    func profileUpdate(profileImageUrl: URL, selectedPost: Post) {
//        let uid = selectedPost.currentUser
//        name = users.filter{ $0.id == uid }[0].name
//        nickName = users.filter{ $0.id == uid }[0].nickName
//        signUpEmail = users.filter{ $0.id == uid }[0].email
//
//        let userData = ["name": name, "nickName": nickName, "email": signUpEmail, "uid": uid, "profileImageUrl": profileImageUrl.absoluteString]
//
//        Firestore.firestore().collection("users").document(uid).setData(userData as [String : Any]) { error in
//            if let error = error {
//                print(error)
//                return
//            }
//        }
//
//        self.fetchUser()
//    }
//
//
//    func findPostNickname(selectedPost : Post) -> String {
//        let uid: String = selectedPost.currentUser
//
//        let myUser: MyUser = users.filter{ $0.id == uid }[0]
//
//        if myUser.nickName != "" {
//            return myUser.nickName
//        } else {
//            return "can't find nickname"
//        }
//    }
//
//    func findCommentNickname(comment : Comment) -> String {
//        let uid: String = comment.currentUser
//        let myUser: MyUser = users.filter{ $0.id == uid }[0]
//
//        if myUser.nickName != "" {
//            return myUser.nickName
//        } else {
//            return "can't find nickname"
//        }
//    }
//
//    func findPostProfileImageUrlString(selectedPost : Post) -> String {
//        let uid: String = selectedPost.currentUser
//        if !users.isEmpty {
//            let myUser: MyUser = users.filter{ $0.id == uid }[0]
//            return myUser.profileImageUrl
//        } else {
//            return ""
//        }
//
//    }
//
//    func findCommentProfileImageUrlString(comment : Comment) -> String {
//        let uid: String = comment.currentUser
//        if !users.isEmpty {
//            let myUser: MyUser = users.filter{ $0.id == uid }[0]
//            return myUser.profileImageUrl
//        } else {
//            return ""
//        }
//    }
}

