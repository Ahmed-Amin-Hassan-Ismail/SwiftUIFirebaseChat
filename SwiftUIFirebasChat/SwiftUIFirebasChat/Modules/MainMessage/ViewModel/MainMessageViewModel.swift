//
//  MainMessageViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import Foundation


class MainMessageViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var shouldShowNewMessageScreen: Bool = false
    @Published var shouldShowLogoutAlert: Bool = false
    @Published var shouldNavigateToChatLogView: Bool = false
    @Published var isUserLoggedOut: Bool = false
    @Published var errorMessage: String = ""
    @Published var isGetAnError: Bool = false
    @Published var user: User?
    @Published var selectedUser: User?
    @Published var recentMessages = [ChatMessage]()
    
    //MARK: - Init
    
    init() {
        
        guard !ifUserLoggedOut() else { return }
        fetchCurrentUser()
    }
    
    //MARK: - Methods
    
    func signOut() {
        
        isUserLoggedOut = true
        FirebaseManager.shared.handleSignOut()
    }
    
    //MARK: - Private Methods
    
    private func fetchCurrentUser() {
        
        FirebaseManager.shared.fetchCurrentUser { [weak self] snapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.isGetAnError = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            guard let data = snapshot?.data() else { return }
            
            self.user = User(data: data)
            self.fetchRecentMessages()
        }
    }
    
    private func fetchRecentMessages() {
        
        guard let user = user else { return }
        
        let chatMessage = ChatMessage(
            fromId: FirebaseManager.shared.getCurrentUserUid(),
            toId: user.uid,
            email: user.email,
            profileImageUrl: user.profileImageUrl
        )
        
        FirebaseManager.shared.fetchRecentMessages(with: chatMessage) { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error!.localizedDescription
                self.isGetAnError = true
                return
            }
            
            querySnapshot?.documentChanges.forEach({ documentChange in
                let documentId = documentChange.document.documentID
                let data = documentChange.document.data()
                
                if let index = self.recentMessages.firstIndex(where: { $0.documentId == documentId }) {
                    self.recentMessages.remove(at: index)
                }
                
                self.recentMessages.insert(.init(documentId: documentId, data: data), at: 0)
            })
        }
    }
    
    private func ifUserLoggedOut() -> Bool {
        
        isUserLoggedOut = FirebaseManager.shared.getCurrentUserUid().isEmpty
        
        return isUserLoggedOut
    }
}
