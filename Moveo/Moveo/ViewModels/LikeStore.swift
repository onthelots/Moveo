//
//  LikeStore.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/21.
//

import Foundation
import FirebaseFirestore

class LikeStore: ObservableObject {
    // 좋아요를 저장하는 배열
    @Published var likes: [Like] = []
    
    var postId: String?
    
    // likes를 store에서 받아서 likes에 넣어주는 기능
    func fetchLikes(post: Post) {
        let id = post.id
        Firestore.firestore().collection("post").document(id)
            .collection("Likes")
            .getDocuments { (snapshot, error) in
                self.likes.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let docData = document.data()
                        let id: String = docData["id"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let profileImage: String = docData["profileImage"] as? String ?? ""
                        
                        let like: Like = Like(id: id, nickName: nickName, profileImage: profileImage)
                        
                        self.likes.append(like)
                    }
                }
            }
        print("success fetchLikes")
    }
    
    // likes를 store에 추가해주는 기능
    func addLike(post: Post, currentUid: String, currentNickName: String, currentProfileImage: String) {
        let id = post.id
        let like = ["id": currentUid, "nickName": currentNickName, "currentProfileImage": currentProfileImage]
        
        Firestore.firestore().collection("post").document(id)
            .collection("Likes")
            .document(currentUid)
            .setData(like as [String: Any]) { error in
                if let error = error {
                    print(error)
                    return
                }
                
                print("Add Like Success")
            }
        fetchLikes(post: post)
    }
    
    // likes를 store에서 삭제하는 기능
    func deleteLike(post: Post, currentUid: String) {
        let id = post.id
        
        Firestore.firestore().collection("post").document(id)
            .collection("Likes")
            .document(currentUid)
            .delete()
        
        print("Delete Like Success")
        fetchLikes(post: post)
    }
    
    // TODO: - 아직 미완성이라 모든 post에 좋아요가 눌려진 것 처럼 나옴 / 현재 사용자가 해당 포스트에 like를 눌렀는지 판별해주는 기능
    func likeCheck(post: Post, currentUid: String) -> Bool {
        let id = post.id
        var likeUsers: [String] = []
        var result: Bool = false
        
        Firestore.firestore().collection("post").document(id)
            .collection("Likes")
            .getDocuments { (snapshot, error) in
                if let snapshot {
                    for document in snapshot.documents {
                        let docData = document.data()
                        let id: String = docData["id"] as? String ?? ""
                        
                        likeUsers.append(id)
                    }
                    
                    if likeUsers.contains(currentUid) {
                        result = true
                    }
                }
            }
        
        return result
    }
}
