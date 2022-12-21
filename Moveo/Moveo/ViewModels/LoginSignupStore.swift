
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
    
    // 로딩-로그인 뷰 체인저
    @Published var lodingViewChanger: Bool = true
    
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
    @Published var selectedCategories : [String] = []
    @Published var bookmark : [String] = []
    @Published var description : String = ""
    // 프로필
    @Published var profileImageUrl: UIImage?
    //    @Published var currentUserInfo: [MyUser] = []
    
    // 로그인 상태 확인
    @Published var currentUser: Firebase.User?
    
    // 화면전환 토글
    @Published var viewChangeToggle: Bool = false
    
    // User 배열
    @Published var users : [User] = []
    
    // current user Data
    @Published var currentUserData: User? = nil
    
    init() {
        currentUser = Auth.auth().currentUser
        print("현재 유저 uid \(currentUser?.uid ?? "")")
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
        self.fetchUser()
    }
    
    // 로그아웃
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // 회원가입
    func createNewAccount() {
        Auth.auth().createUser(withEmail: signUpEmail, password: signUpPw) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            //            self.storeUserInfoToDatabase(uid: result?.user.uid ?? "")
            self.storeUserInfoToDatabase(uid: result?.user.uid ?? "")
        }
    }
    
    // user 정보 database에 저장
    func storeUserInfoToDatabase(uid: String) {
        
        let uid = uid
        
        let ref = Storage.storage().reference(withPath: uid)
        
        guard let imageData = profileImageUrl?.jpegData(compressionQuality: 0.5) else {
            return
        }
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("\(error)")
                return
            }
            ref.downloadURL() { url, error in
                if let error = error {
                    print(error)
                    return
                }
                print(url?.absoluteString ?? "망함")
                
                guard let url = url else { return }
                
                print(uid)
                // model을 쓰면 쉽게 구조화할 수 있음
                let userData = ["name" : self.name, "nickName" : self.nickName, "email" : self.signUpEmail, "id" : uid, "profileImageUrl": url.absoluteString, "category": self.selectedCategories, "bookmark" : self.bookmark, "description" : self.description] as [String : Any]
                
                Firestore.firestore().collection("users").document(uid).setData(userData as [String : Any]) { error in
                    if let error = error {
                        print(error)
                        return
                    }
                    print("success")
                }
            }
            
        }
        fetchUser()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users")
            .getDocuments { (snapshot, error) in
                self.users.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        
                        let docData = document.data()
                        // 있는지를 따져서 있으면 String으로 만들어줘, 없으면 ""로 만들자
                        let id: String = docData["id"] as? String ?? ""
                        let name: String = docData["name"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let email: String = docData["email"] as? String ?? ""
                        let profileImageUrl: String = docData["profileImageUrl"] as? String ?? ""
                        let category : [String] = docData["category"] as? [String] ?? []
                        let bookmark : [String] = docData["bookmark"] as? [String] ?? []
                        let description : String = docData["description"] as? String ?? ""
                        let user: User = User(id: id, email: email, name: name, nickName: nickName, profileImageUrl: profileImageUrl, category: category, bookmark: bookmark, description: description)
                        
                        self.users.append(user)
                    }
                }
            }
    }
    
    func profileImageToStorage(selectedPost: Post) {
        let uid = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: uid)
        
        guard let imageData = profileImageUrl?.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("\(error)")
                return
            }
            
            ref.downloadURL() { url, error in
                if let error = error {
                    print(error)
                    return
                }
                print(url?.absoluteString ?? "망함")
                
                guard let url = url else { return }
                
                self.profileUpdate(profileImageUrl: url, selectedPost: selectedPost)
            }
        }
    }
    
    func profileUpdate(profileImageUrl: URL, selectedPost: Post) {
        let uid = selectedPost.writerUid
        name = users.filter{ $0.id == uid }[0].name
        nickName = users.filter{ $0.id == uid }[0].nickName
        signUpEmail = users.filter{ $0.id == uid }[0].email
        
        let userData = ["name": name, "nickName": nickName, "email": signUpEmail, "uid": uid, "profileImageUrl": profileImageUrl.absoluteString]
        
        Firestore.firestore().collection("users").document(uid).setData(userData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
        }
        
        self.fetchUser()
    }
    
    func currentUserDataInput() {
        let uid: String = currentUser?.uid ?? ""

        if !users.isEmpty {
            let myUser: User = users.filter{ $0.id == uid }[0]
            currentUserData = myUser
        }
    }
    
    func findPostNickname(selectedPost : Post) -> String {
        let uid: String = selectedPost.writerUid
        
        let myUser: User = users.filter{ $0.id == uid }[0]
        
        if myUser.nickName != "" {
            return myUser.nickName
        } else {
            return "can't find nickname"
        }
    }
    
    func findPostProfileImageUrlString(selectedPost : Post) -> String {
        let uid: String = selectedPost.writerUid
        if !users.isEmpty {
            let myUser: User = users.filter{ $0.id == uid }[0]
            return myUser.profileImageUrl
        } else {
            return ""
        }
        
    }
    
    func findCommentNickname(comment : Comment) -> String {
        let uid: String = comment.uid
        let myUser: User = users.filter{ $0.id == uid }[0]
        
        if myUser.nickName != "" {
            return myUser.nickName
        } else {
            return "can't find nickname"
        }
    }
    
    
    
    func findCommentProfileImageUrlString(comment : Comment) -> String {
        let uid: String = comment.uid
        if !users.isEmpty {
            let myUser: User = users.filter{ $0.id == uid }[0]
            return myUser.profileImageUrl
        } else {
            return ""
        }
    }
    
    func currentUserImageUrlString() -> String {
        let uid: String = currentUser?.uid ?? ""
        
        if !users.isEmpty {
            let myUser: User = users.filter{ $0.id == uid }[0]
            return myUser.profileImageUrl
        } else {
            return ""
        }
    }
    
    // 북마크한 게시물들을 UserStore에 올리기, 삭제하기
    func uploadBookmarkedPost(selectedPostId: String) {
        
        let user = self.currentUserData
        let userData = ["id" : user?.id ?? "", "email" : user?.email ?? "", "name" : user?.name ?? "", "nickName" : user?.nickName ?? "", "profileImageUrl" : user?.profileImageUrl ?? "", "category" : user?.category ?? [], "bookmark" : user?.bookmark ?? [], "description" : user?.description ?? "" ] as [String : Any]
        Firestore.firestore().collection("users").document(user?.id ?? "").setData(userData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
        }
        fetchUser()
    }
}

