//
//  MessageView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import SwiftUI

struct MessageView: View {
    
    //MARK: - Body
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 16) {
                
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                    )
                    .padding(.vertical, 5)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Ahmed Amin")
                        .font(.system(size: 16, weight: .bold))
                    
                    Text("this message from amin")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.lightGray))
                }
                
                Spacer()
                
                Text("22m")
                    .font(.system(size: 14.0, weight: .semibold))
                            
            }
            
            Divider()
                .padding(.vertical, 8)
        }
        .padding(.horizontal)
        
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
