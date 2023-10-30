//
//  FashionStoreApp.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 03/10/23.
//

import SwiftUI
import Firebase

@main
struct FashionStoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabBar()
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configure Firebase🚀")
        return true
    }
}
