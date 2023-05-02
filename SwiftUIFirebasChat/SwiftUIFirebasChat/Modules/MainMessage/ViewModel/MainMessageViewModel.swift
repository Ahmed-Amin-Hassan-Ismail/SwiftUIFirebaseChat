//
//  MainMessageViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import Foundation


class MainMessageViewModel: ObservableObject {

    //MARK: - Properties
    
    @Published var shouldShowLogoutAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isGetAnError: Bool = false
    @Published var user: User?
    
    //MARK: - Init
    
    init() {
        fetchCurrentUser()
    }
    
    //MARK: - Methods
    
    func logout() {
        
        //TODO: - not implemented yet
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
            
            let uid = data["uid"] as? String
            let firstName = data["firstName"] as? String
            let lastName = data["lastName"] as? String
            let email = data["email"] as? String
            let profileImageUrl = data["profileImageUrl"] as? String
            
            self.user = User(
                uid: uid,
                firstName: firstName,
                lastName: lastName,
                email: email,
                profileImageUrl: profileImageUrl
            )
        }
    }
}
