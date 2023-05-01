//
//  LoginViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var isLoginMode: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isErrorOccured: Bool = false
    @Published var errorMessage: String = ""
    
    
    //MARK: - Methods
    
    func handleAction() {
        if isLoginMode { // click on login button
            
            userLogin()
            
        } else { // click on create button
            
            createNewUser()
        }
    }
    
    //MARK: - Private Methods
    
    private func createNewUser() {
        
        FirebaseManager.shared.createNewUser(with: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.isErrorOccured = true
                self?.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully Create new account \(result!.user.uid)")
        }
    }
    
    private func userLogin() {
        
        FirebaseManager.shared.loginUser(with: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.isErrorOccured = true
                self?.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully login with user: \(result!.user.uid)")
        }
    }
}
