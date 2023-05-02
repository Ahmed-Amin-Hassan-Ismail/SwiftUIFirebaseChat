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
    @Published var shouldShowImagePicker: Bool = false
    @Published var isErrorOccured: Bool = false
    @Published var errorMessage: String = ""
    
    
    //MARK: - Methods
    
    func handleAction(with user: User) {
        if isLoginMode { // click on login button
            
            login(with: user)
            
        } else { // click on create button
            
            createNewUser(with: user)
        }
    }
}


//MARK: - Create New Account

extension LoginViewModel {
    
    private func createNewUser(with user: User) {
        
        FirebaseManager.shared.createNewUser(with: user.email.stringValue,
                                             password: user.password.stringValue) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully Create new account \(result!.user.uid)")
            
            self.persistImageToStorage(with: user)
        }
    }
    
    private func persistImageToStorage(with user: User) {
        
        guard let imageData = user.profileImageData else { return }
        FirebaseManager.shared.pushImageIntoStorage(imageData: imageData) { [weak self] url, error in
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully store image with url \(url?.absoluteString ?? "")")
            
            self.storeInformation(of: user, with: url)
        }
        
    }
    
    private func storeInformation(of user: User, with imageUrl: URL?) {
        guard let url = imageUrl else { return }
        let userData = [
            "firstName": user.firstName.stringValue,
            "lastName": user.lastName.stringValue,
            "email": user.email.stringValue,
            "uid": FirebaseManager.shared.getCurrentUserUid(),
            "profileImageUrl": url.absoluteString
        ]
        
        FirebaseManager.shared.storeUserInformation(with: userData) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Success create collection data")
        }
    }
}


//MARK: - Login Account

extension LoginViewModel {
    
    private func login(with user: User) {
        
        FirebaseManager.shared.loginUser(with: user.email.stringValue,
                                         password: user.password.stringValue) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully login with user: \(result!.user.uid)")
        }
    }
}
