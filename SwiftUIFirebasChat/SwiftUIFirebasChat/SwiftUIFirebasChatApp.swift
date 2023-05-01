//
//  SwiftUIFirebasChatApp.swift
//  SwiftUIFirebasChat
//
//  Created by Ahmed Amin on 01/05/2023.
//

import SwiftUI

@main
struct SwiftUIFirebasChatApp: App {
    
    //MARK: - Properties
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate /// register appDelegate to initialize firebase 
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}


//MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Firebase.instance.configure()
        
        return true
    }
}
