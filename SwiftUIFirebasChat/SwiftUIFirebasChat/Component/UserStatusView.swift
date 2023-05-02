//
//  UserStatusView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import SwiftUI

struct UserStatusView: View {
    
    //MARK: - Body
    
    let user: User?
    
    @Binding var shouldShowLogoutAlert: Bool
    
    
    //MARK: - Body
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 48, height: 48)
                .overlay(
                    AsyncImage(url: user?.imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .cornerRadius(24)
                        
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                    }
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user?.fullName ?? "")
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    
                    Text("Online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            
            Button {
                shouldShowLogoutAlert.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .heavy))
                    .foregroundColor(Color(.label))
            }
            
            
        }
        .padding()
    }
}

//MARK: - Helper Methods

extension UserStatusView {
    private func handleLogoutAction() {
        //TODO: - not implemented yet
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView(user: dev.user, shouldShowLogoutAlert: .constant(false))
    }
}
