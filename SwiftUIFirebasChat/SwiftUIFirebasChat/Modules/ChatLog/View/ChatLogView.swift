//
//  ChatLogView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct ChatLogView: View {
    
    //MARK: - Properties
    
    @ObservedObject private var viewModel: ChatLogViewModel
    private let scrollToLastMessage: String = "lastMessage"
    
    //MARK: - Init
    
    init(user: User?) {
        self.viewModel = ChatLogViewModel(user: user)
    }
    
    
    //MARK: - Body
    
    var body: some View {
            VStack {
                
                Spacer()
                
                userMessages
                
                chatBarView
            }
            .alert(viewModel.errorMessage,
                   isPresented: $viewModel.isErrorOccurred,
                   actions: { })
            .navigationTitle(viewModel.user?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
       
    }
}


//MARK: - Helper Methdods

extension ChatLogView {
    
    private var userMessages: some View {
        
        ZStack {
            if viewModel.chatMessages.isEmpty {
                
                LottieView(lottieFile: "emptyMessage")
                
            } else {
                ScrollView(showsIndicators: false) {
                    
                    ScrollViewReader { scrollViewProxy in
                        
                        VStack {
                            ForEach(viewModel.chatMessages) { message in
                                
                                ChatMessageView(chatMessage: message)
                            }
                        }
                        .id(scrollToLastMessage)
                        .onReceive(viewModel.$addNewMessageByOne) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(scrollToLastMessage, anchor: .bottom)
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1.0)))
    }
    
    private var chatBarView: some View {
        
        HStack(spacing: 16 ) {
            
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            
            
            ZStack {
                descriptionPlaceholder
                TextEditor(text: $viewModel.chatTextMessage)
                    .opacity(viewModel.chatTextMessage.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            
            Button {
                
                viewModel.handleSendAction()
                
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
    
    private var descriptionPlaceholder: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(user: dev.user)
        }
    }
}
