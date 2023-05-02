//
//  PreviewProvider.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import SwiftUI


extension PreviewProvider {
    
    static var dev: DeveloperPreview  {
        
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    //MARK: - Singleton
    
    static let instance: DeveloperPreview = {
        return DeveloperPreview()
    }()
    
    private init() { }
    
    let user = User(
        uid: "1234567890",
        firstName: "Ahmed",
        lastName: "Amin",
        email: "ahmed.amin@gmail.com",
        profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/swftuifirebasechat.appspot.com/o/nW3AfPSjEOUxI42n4VL6dwu3GeH3?alt=media&token=cf3ae7a2-aac2-40b5-8391-c65ec0bab4da"
    )
    
}
