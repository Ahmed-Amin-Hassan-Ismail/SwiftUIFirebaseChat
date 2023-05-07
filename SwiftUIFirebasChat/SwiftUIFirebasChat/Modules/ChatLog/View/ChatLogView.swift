//
//  ChatLogView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct ChatLogView: View {
    
    //MARK: - Properties
    
    let user: User?
    
    //MARK: - Body
    
    var body: some View {
        
            ScrollView {
                
                ForEach(0..<10, id: \.self) { _ in
                    Text("This is fake message")
                }
            }
            .navigationTitle(user?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(user: dev.user)
    }
}
