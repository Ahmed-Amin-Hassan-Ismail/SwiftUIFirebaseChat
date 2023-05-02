//
//  Optional.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 02/05/2023.
//

import Foundation


extension Optional where Wrapped == String {
    
    var stringValue: String {
        guard let self = self else { return "" }
        return self
    }
}
