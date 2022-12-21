//
//  LikeStore.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/21.
//

import Foundation
import FirebaseFirestore

class LikeStore: ObservableObject {
    @Published var likes: [Like] = []
    
    var postId: String?
    
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
    
    func deleteLike(post: Post, currentUid: String) {
        let id = post.id
        
        Firestore.firestore().collection("post").document(id)
            .collection("Likes")
            .document(currentUid)
            .delete()
        
        print("Delete Like Success")
        fetchLikes(post: post)
    }
    
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
