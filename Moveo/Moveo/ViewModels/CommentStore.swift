

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var commentText: String = ""
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        return dateFormatter
    }()
    
    var postId: String?
    
    func fetchComments() {
        Firestore.firestore().collection("post").document(postId ?? "")
            .collection("Comments")
            .order(by: "date", descending: false)
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
    }
    
    func addComment(currentNickName: String, currentProfileImage: String) {
        let id: String = UUID().uuidString
        let comment = ["id": id, "uid": Auth.auth().currentUser?.uid, "commentText": commentText, "date": dateFormatter.string(from: Date.now)]
        
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
