//
//  PostStore.swift
//  Moveo
//
//  Created by 진준호 on 2022/12/19.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage

class PostStore: ObservableObject {
    // 데이터베이스에서 정보를 받아와서 Post 구조체의 배열로 만들기 위해서 필요
    @Published var posts: [Post] = []
    
    // UIImage 형식이기 때문에 url을 붙이면 헷갈림 그래서 그냥 postImage
    @Published var postImage: UIImage?
    @Published var bodyText: String = ""
    
    // TODO: - 임시로 넣은 변수, 나중에 현재 유저의 정보를 따로 저장해놓을 수 있는 곳을 만들어서 보내줄 수 있으면 좋을 듯
    @Published var nickName: String = ""
    @Published var profileImage: String = ""
    @Published var postCategory: String = ""
    
    // MARK: - 사진을 Storage에 담아주고 거기서 url값을 추출하는 함수
    func ImageToStorage() {
        let uid = UUID().uuidString
        let ref = Storage.storage().reference(withPath: uid)
        
        guard let imageData = postImage?.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        // Storage에 image를 담아줌
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("\(error)")
                return
            }
            
            // Storage에서 image의 url값을 추출해줌
            ref.downloadURL() { url, error in
                if let error = error {
                    print(error)
                    return
                }
                print(url?.absoluteString ?? "망함")
                
                guard let url = url else { return }
                
                // url 값을 추출해서 store로 전달해줘야 함, uid 값은 post의 uid값과 해당 post에 들어가는 image의 uid값을 동일하게 해주기 위해 전달
                self.addPost(imageProfileUrl: url, uid: uid)
            }
        }
    }
    
    // MARK: - post를 database에 추가하는 함수
    // image의 url 값을 받아와서 bodyText, postDate 등 다른 데이터들과 함께 store에 저장함
    func addPost(imageProfileUrl: URL, uid: String) {
        let uid = uid
        
        // 날짜를 원하는 형식으로 변환 - 우리는 데이터순으로 정렬을 해줄거여서 초단위까지 필요하기 때문에 이렇게 형식을 변환하였음
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

            return dateFormatter
        }()
         
        
        // model을 쓰면 쉽게 구조화할 수 있음
        let postData = ["id": uid, "postImageUrl": imageProfileUrl.absoluteString, "bodyText" : bodyText, "writerUid": Auth.auth().currentUser?.uid, "date": dateFormatter.string(from: Date.now), "nickName": nickName, "profileImage": profileImage, "postCategory": postCategory]
                            
        Firestore.firestore().collection("post").document(uid).setData(postData as [String : Any]) { error in
            if let error = error {
                print(error)
                return
            }
            print("Post to Store success")
        }
        
        fetchPosts()
        
        bodyText = ""
        postImage = nil
    }
    
    // MARK: - Post들을 store에서 받아와서 뷰에 새로 그려주기 위해 Posts를 패치하는 함수
    func fetchPosts() {
        Firestore.firestore().collection("post")
            .order(by: "date", descending: true)
            .getDocuments { (snapshot, error) in
                self.posts.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        
                        let docData = document.data()
                        // 있는지를 따져서 있으면 String으로 만들어줘, 없으면 ""로 만들자
                        let uid: String = docData["id"] as? String ?? ""
                        let writerUid: String = docData["writerUid"] as? String ?? ""
                        let bodyText: String = docData["bodyText"] as? String ?? ""
                        let postImageUrl: String = docData["postImageUrl"] as? String ?? ""
                        let postDate: String = docData["postDate"] as? String ?? ""
                        let nickName: String = docData["nickName"] as? String ?? ""
                        let profileImage: String = docData["profileImage"] as? String ?? ""
                        let postCategory: String = docData["postCategory"] as? String ?? ""
                        
                        let post: Post = Post(id: uid, bodyText: bodyText, postImageUrl: postImageUrl, postDate: postDate, postCategory: postCategory, writerUid: writerUid, profileImage: profileImage, nickName: nickName)
                        
                        self.posts.append(post)
                    }
                }
            }
    }
}
