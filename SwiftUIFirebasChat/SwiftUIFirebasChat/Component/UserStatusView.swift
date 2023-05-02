//
//  UserStatusView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import SwiftUI

struct UserStatusView: View {
    
    //MARK: - Body
    
    @Binding var showShowLogoutOptions: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("username".capitalized)
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
                showShowLogoutOptions.toggle()
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
        
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView(showShowLogoutOptions: .constant(false))
    }
}
