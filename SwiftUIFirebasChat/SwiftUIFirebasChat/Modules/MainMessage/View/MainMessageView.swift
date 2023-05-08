//
//  MainMessageView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import SwiftUI

struct MainMessageView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = MainMessageViewModel()
    
    //MARK: - Body
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                UserStatusView(user: viewModel.user,
                               shouldShowLogoutAlert: $viewModel.shouldShowLogoutAlert)
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.recentMessages) { message in
                        MessageView(message: message)
                            .onTapGesture {
                                viewModel.shouldNavigateToChatLogView = true
                                //navigateToChatLogView(with: <#T##User?#>)
                            }
                    }
                }
            }
            .overlay(newMessageButton, alignment: .bottom)
            .background( navigateToChatLogView(with: viewModel.selectedUser) )
            .alert(viewModel.errorMessage,
                   isPresented: $viewModel.isGetAnError,
                   actions: { /* not implemented yet */ })
            .actionSheet(isPresented: $viewModel.shouldShowLogoutAlert,
                         content: handleActionSheet)
            .fullScreenCover(isPresented: $viewModel.shouldShowNewMessageScreen,
                             content: { showNewMessageView })
            .fullScreenCover(isPresented: $viewModel.isUserLoggedOut,
                             content: { LoginView() })
            .navigationBarHidden(true)
        }
    }
}

//MARK: - Methods View

extension MainMessageView {
    
    private var newMessageButton: some View {
        Button {
            viewModel.shouldShowNewMessageScreen = true
            
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("New Message")
            }
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundColor(.white)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(24)
        .padding(.horizontal)
    }
}

//MARK: - Helper Methods

extension MainMessageView {
    
    private func handleActionSheet() -> ActionSheet {
        ActionSheet.init(
            title: Text("Settings".uppercased()),
            message: Text("What do you want to do?"),
            buttons: [
                .destructive(Text("Sign out")) {
                    viewModel.signOut()
                },
                .cancel()
            ])
    }
    
    private func navigateToChatLogView(with user: User?) -> some View {
        NavigationLink(
            destination: ChatLogView(user: user),
            isActive: $viewModel.shouldNavigateToChatLogView,
            label: { EmptyView() }
        )
        
    }
    
    private var showNewMessageView: some View {
        CreateNewMessageView { user in
            viewModel.shouldNavigateToChatLogView = true
            viewModel.selectedUser = user
        }
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}
