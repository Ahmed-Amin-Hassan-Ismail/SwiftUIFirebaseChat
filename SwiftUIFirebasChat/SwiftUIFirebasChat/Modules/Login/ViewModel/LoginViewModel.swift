//
//  LoginViewModel.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import SwiftUI


class LoginViewModel: ObservableObject {
    
    //MARK: - Properties
    
    @Published var isLoginMode: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var shouldShowImagePicker: Bool = false
    @Published var profileImage: UIImage?
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
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully Create new account \(result!.user.uid)")
            
            self.persistImageToStorage()
        }
    }
    
    private func persistImageToStorage() {
        
        guard let image = profileImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        FirebaseManager.shared.pushImageIntoStorage(imageData: imageData) { [weak self] url, error in
            guard let self = self else { return }
            guard error == nil else {
                self.isErrorOccured = true
                self.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            print("Successfully store image with url \(url?.absoluteString ?? "")")
            
            self.storeUserInformation(with: url)
        }
        
    }
    
    private func storeUserInformation(with imageUrl: URL?) {
        guard let url = imageUrl else { return }
        let userData = [
            "email": email,
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
    
    private func userLogin() {
        
        FirebaseManager.shared.loginUser(with: email, password: password) { [weak self] result, error in
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
