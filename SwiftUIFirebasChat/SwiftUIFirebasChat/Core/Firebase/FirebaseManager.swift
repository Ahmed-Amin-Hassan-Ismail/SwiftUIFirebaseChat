//
//  FirebaseManager.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager {
    
    //MARK: - Singleton
    
    static let shared: FirebaseManager = {
        return FirebaseManager()
    }()
    
    private let userCollectionName: String = "Users"
    private let messageCollectionName: String = "Messages"
    private let recentMessageName: String = "Recent_Messages"
    
    private init() { }
    
    //MARK: - Methods
    
    func configure() {
        
        FirebaseApp.configure()
    }
    
    func createNewUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(result, error)
        }
    }
    
    func loginUser(with email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(result, error)
        }
    }
    
    func pushImageIntoStorage(imageData: Data, completion: @escaping (URL?, Error?) -> Void) {
        
        let ref = Storage.storage().reference(withPath: getCurrentUserUid())
        ref.putData(imageData) { (_, error) in
            completion(nil, error)
            ref.downloadURL { url, error in
                completion(url, error)
            }
        }
    }
    
    func storeUserInformation(with userData: [String: Any], completion: @escaping (Error?) -> Void) {
        
        Firestore.firestore().collection(userCollectionName).document(getCurrentUserUid()).setData(userData) { error in
            completion(error)
        }
    }
    
    
    func fetchCurrentUser(completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        
        Firestore.firestore().collection(userCollectionName).document(getCurrentUserUid()).getDocument { snapshot, error in
            completion(snapshot, error)
        }
    }
    
    func fetchAllUsers(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        
        Firestore.firestore().collection(userCollectionName).getDocuments { querySnapShot, error in
            completion(querySnapShot, error)
        }
    }
    
    func saveMessageIntoStore(with chatMessage: ChatMessage, completion: @escaping ((Error?) -> Void))  {
        
        let data: [String: Any] = [
            "fromId": chatMessage.fromId ?? "",
            "toId": chatMessage.toId ?? "",
            "text": chatMessage.text ?? "",
            "timestamp": Timestamp(),
            "profileImageUrl": chatMessage.profileImageUrl ?? "",
            "email": chatMessage.email ?? ""
            ]
        
        Firestore.firestore().collection(messageCollectionName).document(chatMessage.fromId ?? "").collection(chatMessage.toId ?? "").document().setData(data) { error in
            completion(error)
        }
        
        Firestore.firestore().collection(messageCollectionName).document(chatMessage.toId ?? "").collection(chatMessage.fromId ?? "").document().setData(data) { error in
            completion(error)
        }
        
    }
    
    func fetchAllMessages(with chatMessage: ChatMessage, completiobn: @escaping (QuerySnapshot?, Error?) -> Void) {
        
        Firestore.firestore().collection(messageCollectionName).document(chatMessage.fromId ?? "").collection(chatMessage.toId ?? "").order(by: "timestamp").addSnapshotListener { querySnapshot, error in
            completiobn(querySnapshot, error)
        }
    }
    
    func persistLastMessage(with chatMessage: ChatMessage, completion: @escaping (Error?) -> Void) {
        
        let data: [String: Any] = [
            "fromId": chatMessage.fromId ?? "",
            "toId": chatMessage.toId ?? "",
            "text": chatMessage.text ?? "",
            "timestamp": Timestamp(),
            "profileImageUrl": chatMessage.profileImageUrl ?? "",
            "email": chatMessage.email ?? ""
            ]
        
        Firestore.firestore().collection(recentMessageName).document(chatMessage.fromId ?? "").collection(messageCollectionName).document(chatMessage.toId ?? "").setData(data) { error in
            completion(error)
        }
    }
    
    func handleSignOut() {
        do {
            
            try Auth.auth().signOut()
            
        } catch {
            
            print("Error: \(error)")
        }
    }
    
    //MARK: - Getters
    
    func getCurrentUserUid() -> String {
        
        return Auth.auth().currentUser?.uid ?? ""
    }
}


