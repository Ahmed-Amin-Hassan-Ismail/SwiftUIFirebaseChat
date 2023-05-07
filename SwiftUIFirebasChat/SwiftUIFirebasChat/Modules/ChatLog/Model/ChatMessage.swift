//
//  ChatMessage.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import Foundation



struct ChatMessage: Codable, Identifiable {
    
    var fromId: String?
    var toId: String?
    var text: String?
    var timestamp: String?
    var documentId: String?
    
    var id: String {
        return documentId ?? ""
    }
    
}

extension ChatMessage {
    
    init(documentId: String?, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String
        self.toId = data["toId"] as? String
        self.text = data["text"] as? String
        self.timestamp = data["timestamp"] as? String
    }
}
