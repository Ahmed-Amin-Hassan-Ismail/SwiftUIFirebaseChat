//
//  CreateNewMessageView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct CreateNewMessageView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = CreateNewMessageViewModel()
    @Environment(\.dismiss) var dismiss
    
    let didSelectNewUser: ((User) -> Void)?
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack {
                    
                    ForEach(viewModel.users) { user in
                        NewUserView(user: user)
                            .onTapGesture {
                                didSelectNewUser?(user)
                                dismiss()
                            }
                    }
                }                
                .alert(viewModel.errorMessage, isPresented: $viewModel.isErrorOccurred, actions: {})
            }
            .overlay(
                LoadingView(showing: $viewModel.shouldShowLoadingView)
            )
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    addCancelButton
                })
            }
        }
    }
}

//MARK: - Helper Methods

extension CreateNewMessageView {
    
    private var addCancelButton: some View {
        Button {
            
            dismiss()
            
        } label: {
            Text("Cancel")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color.red)
        }

    }
    
    
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewMessageView(didSelectNewUser: { _ in })
    }
}
