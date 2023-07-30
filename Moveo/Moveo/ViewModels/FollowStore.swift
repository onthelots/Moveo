//
//  Following.swift
//  Moveo
//
//  Created by 이종현 on 2022/12/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class FollowStore : ObservableObject {
    // 팔로워, 팔로잉들을 저장하는 배열
    @Published var followings : [Following] = []
    @Published var followers : [Follower] = []
    @Published var currentUser: Firebase.User?

  init() {
    currentUser = Auth.auth().currentUser
  }
    
    // 팔로잉된 정보를 store에서 가져오는 기능
  func fetchFollowing() {
      Firestore.firestore().collection("users")
          .document(self.currentUser?.uid ?? "")
          .collection("Following")
          .getDocuments { (snapshot, error) in
              DispatchQueue.main.async { // 메인 스레드에서 처리하도록 수정
                  self.followings.removeAll()

                  if let snapshot = snapshot {
                      for document in snapshot.documents {
                          let docData = document.data()
                          let id : String = docData["id"] as? String ?? ""
                          let nickName: String = docData["nickName"] as? String ?? ""
                          let imageUrl: String = docData["imageUrl"] as? String ?? ""
                          let following: Following = Following(id: id, nickName: nickName, imageUrl: imageUrl)

                          self.followings.append(following)
                      }
                  } else {
                      print("Error fetching following:", error?.localizedDescription ?? "Unknown error")
                  }
              }
          }
  }

    // 팔로워한 정보를 store에서 가져오는 기능
    func fetchFollower() {
        Firestore.firestore().collection("users")
            .document(self.currentUser?.uid ?? "")
            .collection("Follower")
            .getDocuments { (snapshot, error) in
                self.followers.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                     
                        let docData = document.data()
                        let id : String = docData["id"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let imageUrl: String = docData["imageUrl"] as? String ?? ""
                        let follower: Follower = Follower(id: id, nickName: nickName, imageUrl: imageUrl)
                        
                        self.followers.append(follower)
                    }
                }
            }
    }
    
    // 팔로잉한 정보를 store로 보내주는 기능
    func addFollowing(user: User, currentUser: User) {

        let following = ["id" : user.id, "nickName" : user.nickName, "imageUrl" : user.profileImageUrl]
        let follower = ["id" : currentUser.id, "nickName" : currentUser.nickName, "imageUrl" : currentUser.profileImageUrl]
        Firestore.firestore().collection("users").document(currentUser.id)
            .collection("Following")
            .document(user.id)
            .setData(following as [String: Any]) { error in
                if let error = error {
                    print(error)
                    return
                }
                
                print("followingSuccess")
            }
        
        Firestore.firestore().collection("users").document(user.id)
            .collection("Follower")
            .document(currentUser.id)
            .setData(follower as [String: Any]) { error in
                if let error = error {
                    print(error)
                    return
                }
                
                print("followerSuccess")
            }
        fetchFollowing()
        fetchFollower()
    }

    // 팔로잉한 정보를 store에서 삭제하는 기능
    func deleteFollowing(user: User, currentUser: User) {

        Firestore.firestore().collection("users").document(currentUser.id).collection("Following").document(user.id).delete() { err in
            if let err = err {
                print("팔로잉 취소 실패: \(err)")
            } else {
                print("팔로우 취소 성공")
            }
        }
        Firestore.firestore().collection("users").document(user.id).collection("Follower").document(currentUser.id).delete() { err in
            if let err = err {
                print("팔로워 취소 실패: \(err)")
            } else {
                print("팔로워 취소 성공")
            }
        }
        fetchFollowing()
        fetchFollower()
    }
}
