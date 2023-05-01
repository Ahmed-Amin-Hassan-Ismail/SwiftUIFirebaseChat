//
//  Firebase.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import Foundation
import Firebase
import FirebaseCore


class Firebase {
    
    //MARK: - Singleton
    
    static let instance: Firebase = {
        return Firebase()
    }()
    
    private init() { }
    
    func configure() {
        FirebaseApp.configure()
    }
}


