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
        profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/swftuifirebasechat.appspot.com/o/MveSb24UGpQspff0ZTQtMnE61AT2?alt=media&token=9f83f1c5-0a4d-410f-85ac-cb96bf6bc412"
    )
    
}
