

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CommentStore: ObservableObject {
    // 댓글을 저장해줄 배열
    @Published var comments: [Comment] = []
    // 댓글 내용
    @Published var commentText: String = ""
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        return dateFormatter
    }()
    
    var postId: String?
    
    // 댓글들을 store에서 받아와서 comments에 넣어주는 역할
    func fetchComments() {
        Firestore.firestore().collection("post").document(postId ?? "")
            .collection("Comments")
            .order(by: "commentDate", descending: false)
            .getDocuments { (snapshot, error) in
                self.comments.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        
                        let docData = document.data()
                        let uid: String = docData["uid"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let profileImage: String = docData["profileImage"] as? String ?? ""
                        let commentText: String = docData["commentText"] as? String ?? ""
                        let commentDate: String = docData["commentDate"] as? String ?? ""
                        
                        let comment: Comment = Comment(id: id, uid: uid, nickName: nickName, profileImage: profileImage, commentText: commentText, commentDate: commentDate)
                        
                        self.comments.append(comment)
                    }
                }
            }
        print("success fetchComments")
    }
    
    // 댓글을 store에 추가해주는 역할
    func addComment(currentNickName: String, currentProfileImage: String) {
        let id: String = UUID().uuidString
        let comment = ["id": id, "uid": Auth.auth().currentUser?.uid, "nickName": currentNickName, "profileImage": currentProfileImage, "commentText": commentText, "commentDate": dateFormatter.string(from: Date.now)]
        
        Firestore.firestore().collection("post").document(postId ?? "")
            .collection("Comments")
            .document(id)
            .setData(comment as [String: Any]) { error in
                if let error = error {
                    print(error)
                    return
                }
                
                print("commentSuccess")
            }
        fetchComments()
    }
}
