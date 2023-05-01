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
    
    
    //MARK: - Methods
    
    func handleAction() {
        if isLoginMode { // click on login button
            
            print("User Login Successfully")
            
        } else { // click on create button
            
            print("User create new account Successfully")
        }
    }
}
