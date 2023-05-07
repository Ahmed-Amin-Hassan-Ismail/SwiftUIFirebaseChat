//
//  ChatMessageView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct ChatMessageView: View {
    
    //MARK: - Properties
    
    //MARK: - Body
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text("Hello, World!")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding(10)
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView()
    }
}
