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
    @State private var profileImage: UIImage?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    
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
                .alert(viewModel.errorMessage, isPresented: $viewModel.isErrorOccured, actions: {
                    // not implemented yet
                })
                .fullScreenCover(isPresented: $viewModel.shouldShowImagePicker) {
                    ImagePicker(image: $profileImage)
                }
            }
            .navigationTitle(viewModel.isLoginMode ? "Log in" : "Create Account")
            .navigationViewStyle(.stack)
            .background(
                ZStack {
                    Color.init(UIColor(white: 0, alpha: 0.05))
                        .edgesIgnoringSafeArea(.all)

                    NavigationLink(
                        destination: MainMessageView()
                            .navigationBarHidden(true),
                        isActive: $viewModel.isUserLoginSuccessfully,
                        label: { EmptyView() }
                    )
                }
            )
        }
    }
}

//MARK: - Helper Views

extension LoginView {
    
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
            viewModel.shouldShowImagePicker = true
        } label: {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 130, height: 130)
                .overlay(
                    ZStack {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(65)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 65))
                        }
                    }
                )
        }
        .padding(.bottom)
        .foregroundColor(Color(.label))
        .shadow(radius: 30)
    }
    
    private var credentialFieldView: some View {
        Group {
            if !viewModel.isLoginMode {
                TextField("First Name", text: $firstName)
                
                TextField("Last Name", text: $lastName)
            }
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
        }
        .padding([.vertical, .horizontal], 10)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var accountButtonView: some View {
        Button {
            let imageData = profileImage?.jpegData(compressionQuality: 0.5)
            lazy var user = User(firstName: firstName,
                                 lastName: lastName,
                                 email: email,
                                 password: password,
                                 profileImageData: imageData)
            viewModel.handleAction(with: user)
            
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
