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
    
    private let collectionName: String = "Users"
    
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
        
        Firestore.firestore().collection(collectionName).document(getCurrentUserUid()).setData(userData) { error in
            completion(error)
        }
    }
    
    
    func fetchCurrentUser(completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        
        Firestore.firestore().collection(collectionName).document(getCurrentUserUid()).getDocument { snapshot, error in
            completion(snapshot, error)
        }
    }
    
    //MARK: - Getters
    
    func getCurrentUserUid() -> String {
        
        return Auth.auth().currentUser?.uid ?? ""
    }
}


