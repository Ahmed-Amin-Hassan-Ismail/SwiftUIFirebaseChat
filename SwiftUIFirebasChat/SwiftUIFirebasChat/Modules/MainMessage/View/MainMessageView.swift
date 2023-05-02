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
                
                UserStatusView(showShowLogoutOptions: $viewModel.shouldShowLogoutOption)
                
                ScrollView(showsIndicators: false) {
                    ForEach(0..<10, id: \.self) { _ in
                        MessageView()
                    }
                }
                .padding(.bottom, 50)
            }
            .actionSheet(isPresented: $viewModel.shouldShowLogoutOption,
                         content: handleActionSheet)
            .overlay(newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

//MARK: - Methods View

extension MainMessageView {
    
    private var newMessageButton: some View {
        Button {
            
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
                viewModel.logout()
            },
            .cancel()
        ])
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}
