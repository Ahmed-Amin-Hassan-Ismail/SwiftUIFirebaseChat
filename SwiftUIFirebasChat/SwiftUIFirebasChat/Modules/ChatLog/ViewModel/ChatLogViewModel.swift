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
        
        guard let toId = user?.uid else { return }
        
        FirebaseManager.shared.saveMessageIntoStore(with: chatTextMessage, toId: toId) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error?.localizedDescription ?? ""
                self.isErrorOccurred = true
                return
            }
            self.chatTextMessage = ""
            self.addNewMessageByOne += 1
        }
    }
    
    //MARK: - Private Methods
    
    private func fetchAllMessages() {
        
        guard let toId = user?.uid else { return }
        
        FirebaseManager.shared.fetchAllMessages(toId: toId) { [weak self] querySnapshot, error in
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
    
}
