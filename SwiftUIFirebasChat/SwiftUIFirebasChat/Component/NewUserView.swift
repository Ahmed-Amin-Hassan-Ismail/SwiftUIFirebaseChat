//
//  NewUserView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 07/05/2023.
//

import SwiftUI

struct NewUserView: View {
    
    //MARK: - Properties
    
    let user: User?
    
    //MARK: - Body
    
    var body: some View {
        
        VStack() {
            HStack(spacing: 15) {
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: 60, height: 60)
                    .overlay(
                        AsyncImage(url: user?.imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                                .clipped()
                             
                        } placeholder: {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                        }
                    )
                
                Text(user?.email ?? "")
                    .font(.system(.headline, design: .rounded))
                
                Spacer()
            }
            .padding()
            //.padding(.vertical, 10)
            Divider()
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView(user: dev.user)
    }
}
