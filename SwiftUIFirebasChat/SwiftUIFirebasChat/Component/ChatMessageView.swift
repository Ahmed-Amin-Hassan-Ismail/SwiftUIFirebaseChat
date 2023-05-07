//
//  ChatMessageView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct ChatMessageView: View {
    
    //MARK: - Properties
    let chatMessage: ChatMessage
    
    //MARK: - Body
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text(chatMessage.text.stringValue)
                .foregroundColor(isMessageFromCurrentUser() ? .white : .black)
                .padding()
                .background(isMessageFromCurrentUser() ? Color.blue : Color.white)
                .cornerRadius(8)
        }
        .padding(10)
    }
}

extension ChatMessageView {
    
    private func isMessageFromCurrentUser() -> Bool {
        
        return chatMessage.fromId == FirebaseManager.shared.getCurrentUserUid()
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(chatMessage: dev.chatMessage)
    }
}
