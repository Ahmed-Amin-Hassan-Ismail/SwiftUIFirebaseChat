//
//  User.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import Foundation


struct User: Codable {
    
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
}
