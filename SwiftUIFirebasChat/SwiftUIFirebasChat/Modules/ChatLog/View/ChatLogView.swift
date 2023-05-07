//
//  ChatLogView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct ChatLogView: View {
    
    //MARK: - Properties
    
    @StateObject private var viewModel = ChatLogViewModel()
    
    let user: User?
    
    //MARK: - Body
    
    var body: some View {
            VStack {
                
                Spacer()
                
                userMessages
                
                chatBarView
            }
            .navigationTitle("Hello Guys")
            .navigationBarTitleDisplayMode(.inline)
       
    }
}


//MARK: - Helper Methdods

extension ChatLogView {
    
    private var userMessages: some View {
        
        ScrollView(showsIndicators: false) {
            
            ForEach(0..<10, id: \.self) { _ in
                
                ChatMessageView()
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1.0)))
    }
    
    private var chatBarView: some View {
        
        HStack(spacing: 16 ) {
            
            Image(systemName: "photo.on.rectangle")
            
            //TODO: - TextEditor need to use
            TextField("Description", text: $viewModel.chatTextMessage)
            
            Button {
                
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(8)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(user: dev.user)
        }
    }
}
