//
//  LoginView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = LoginViewModel()
    
    //MARK: - Body
    
    var body: some View {
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    
                    segmentedView
                    
                    if !viewModel.isLoginMode {
                        profileImageButtonView
                    }
                    
                    credentialFieldView
                    
                    accountButtonView
                }
                .padding()
            }
            .navigationTitle(viewModel.isLoginMode ? "Log in" : "Create Account")
            .background(
                Color.init(UIColor(white: 0, alpha: 0.05))
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

//MARK: - Helper Views

extension LoginView {
    
    // picker view
   private var segmentedView: some View {
        Picker("Picker Mode", selection: $viewModel.isLoginMode) {
            Text("Login")
                .tag(true)
            Text("Create Account")
                .tag(false)
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
    }
    
    private var profileImageButtonView: some View {
        Button {
            
        } label: {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 130, height: 130)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 65))
                )
        }
        .padding(.bottom)
        .foregroundColor(.black)
        .shadow(radius: 10)
    }
    
    private var credentialFieldView: some View {
        Group {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $viewModel.password)
        }
        .padding([.vertical, .horizontal], 10)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var accountButtonView: some View {
        Button {
            viewModel.handleAction()
            
        } label: {
            Text(viewModel.isLoginMode ? "Log in" : "Create Account")
                .font(.system(size: 16.0, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(8)
        .padding(.vertical)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
