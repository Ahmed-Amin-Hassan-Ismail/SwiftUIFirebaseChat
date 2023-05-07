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
    @Published var errorMessage: String = ""
    @Published var isGetAnError: Bool = false
    @Published var isUserLoggedOut: Bool = false
    @Published var user: User?
    
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
        }
    }
    
    private func ifUserLoggedOut() -> Bool {
        
        isUserLoggedOut = FirebaseManager.shared.getCurrentUserUid().isEmpty
        
        return isUserLoggedOut
    }
}
