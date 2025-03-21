//
//  diary_appApp.swift
//  diary_app
//
//  Created by Quentin Banet on 07/03/2025.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseAppCheck
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

 // ------------- App ------------- //
@main
struct diary_appApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var diary = Diary()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(diary)
        }
    }
}
