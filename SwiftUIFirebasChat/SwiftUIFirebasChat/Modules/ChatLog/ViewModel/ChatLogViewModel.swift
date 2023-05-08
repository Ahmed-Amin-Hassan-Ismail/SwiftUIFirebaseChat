//
//  ChatLogViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import Foundation



class ChatLogViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var chatMessages = [ChatMessage]()
    @Published var chatTextMessage: String = ""
    @Published var addNewMessageByOne: Int = 0
    @Published var errorMessage: String = ""
    @Published var isErrorOccurred: Bool = false
    
    let user: User?
    
    //MARK: - Init
    
    init(user: User?) {
        
        self.user = user
        
        fetchAllMessages()
    }
    
    //MARK: - Methods
    
    func handleSendAction() {
        
        guard let user = user else { return }
        
        let chatMessage = ChatMessage(
            fromId: FirebaseManager.shared.getCurrentUserUid(),
            toId: user.uid,
            text: chatTextMessage,
            email: user.email,
            profileImageUrl: user.profileImageUrl
        )

        FirebaseManager.shared.saveMessageIntoStore(with: chatMessage){ [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error?.localizedDescription ?? ""
                self.isErrorOccurred = true
                return
            }
            self.persistRecentMessage()
            self.chatTextMessage = ""
            self.addNewMessageByOne += 1
        }
    }
    
    //MARK: - Private Methods
    
    private func fetchAllMessages() {
        
        guard let user = user else { return }
        
        let chatMessage = ChatMessage(
            fromId: FirebaseManager.shared.getCurrentUserUid(),
            toId: user.uid,
            text: chatTextMessage,
            email: user.email,
            profileImageUrl: user.profileImageUrl
        )
        
        FirebaseManager.shared.fetchAllMessages(with: chatMessage) { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error?.localizedDescription ?? ""
                self.isErrorOccurred = true
                return
            }
            
            querySnapshot?.documentChanges.forEach({ documentChange in
                if documentChange.type == .added {
                    let documentId = documentChange.document.documentID
                    let data = documentChange.document.data()
                    self.chatMessages.append(.init(documentId: documentId, data: data))
                }
            })
            
            self.addNewMessageByOne += 1
        }
    }
    
    private func persistRecentMessage() {
        
        guard let user = user else { return }
        
        let chatMessage = ChatMessage(
            fromId: FirebaseManager.shared.getCurrentUserUid(),
            toId: user.uid,
            text: chatTextMessage,
            email: user.email,
            profileImageUrl: user.profileImageUrl
        )
        
        FirebaseManager.shared.persistLastMessage(with: chatMessage) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error!.localizedDescription
                self.isErrorOccurred = true
                return
            }
        }
        
        //TODO: - You need to add the similar for recipient users as well ...
    }
}
