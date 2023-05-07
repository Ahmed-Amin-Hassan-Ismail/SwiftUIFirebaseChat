//
//  CreateNewMessageViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import Foundation



class CreateNewMessageViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var users: [User]?
    @Published var errorMessage: String = ""
    @Published var isErrorOccurred: Bool = false
    
    //MARK: - Init
    
    init() {
        
        fetchAllUsers()
    }
    
    //MARK: - Methods
    
    private func fetchAllUsers() {
        
        FirebaseManager.shared.fetchAllUsers { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                self.errorMessage = error?.localizedDescription ?? ""
                self.isErrorOccurred = true
                return
            }
            
            querySnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                let user = User(data: data)
                if user.uid != FirebaseManager.shared.getCurrentUserUid() {
                    if self.users != nil {
                        self.users?.append(.init(data: data))
                    } else {
                        self.users = [User(data: data)]
                    }
                }
                
            })
        }
    }
}
