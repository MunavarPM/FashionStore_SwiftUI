//
//  FashionStoreApp.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 03/10/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FashionStoreApp: App {
    
    @StateObject var productManager = ProductManagerViewModel()
    @StateObject var addressVM = AddressViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                
                    TabBar()
                

                
                //                    .environmentObject(productManager)
                //                    .environmentObject(addressVM)
            }
            .environmentObject(productManager)
            .environmentObject(addressVM)
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
//        print("Configure Firebase🚀")
        return true
    }
}
