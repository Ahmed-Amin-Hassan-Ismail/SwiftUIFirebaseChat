//
//  LoadingView.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 08/05/2023.
//

import SwiftUI

struct LoadingView: View {
    
    //MARK: - Properties
    @Binding var showing: Bool
    
    var body: some View {
        
        ZStack {
            Color(.init(white: 0.8, alpha: 0.3))
                .ignoresSafeArea(.all)
            
            LottieView(lottieFile: "loading")
            
        }
        .opacity(showing ? 1.0 : 0.0)
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(showing: .constant(true))
    }
}
