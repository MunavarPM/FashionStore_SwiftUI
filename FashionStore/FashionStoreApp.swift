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
    init() {
        FirebaseApp.configure()
        print("🥰")
    }
    var body: some Scene {
        WindowGroup {
            OnBoardingTapView()
        }
    }
}
