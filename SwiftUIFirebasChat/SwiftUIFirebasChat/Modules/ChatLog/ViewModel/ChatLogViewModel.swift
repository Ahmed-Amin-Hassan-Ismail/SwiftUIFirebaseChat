//
//  ChatLogViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import Foundation



class ChatLogViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var chatTextMessage: String = ""
    @Published var errorMessage: String = ""
    @Published var isErrorOccurred: Bool = false
    
    let user: User?
    
    //MARK: - Init
    
    init(user: User?) {
        
        self.user = user
    }
    
    //MARK: - Methods
    
    func handleSendAction() {
        
        guard let toId = user?.uid else { return }
        
        FirebaseManager.shared.saveMessageIntoStore(with: chatTextMessage, toId: toId) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error?.localizedDescription ?? ""
                self.isErrorOccurred = true
                return
            }
            self.chatTextMessage = ""
        }
    }
}
