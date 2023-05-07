//
//  User.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import Foundation


struct User: Codable, Identifiable {
    
    var uid: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var profileImageData: Data?
    var profileImageUrl: String?
    
    var fullName: String {
        return firstName.stringValue + " " + lastName.stringValue
    }
    var imageUrl: URL? {
        return URL(string: profileImageUrl ?? "")
    }
    
    var id: String {
        return uid ?? UUID().uuidString
    }
}

/// to not lose memberwise initializer
extension User {
    
    init(data: [String : Any]) {
        
        self.uid = data["uid"] as? String
        self.firstName = data["firstName"] as? String
        self.lastName = data["lastName"] as? String
        self.email = data["email"] as? String
        self.profileImageUrl = data["profileImageUrl"] as? String
    }
    
}
