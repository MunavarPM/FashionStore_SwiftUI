//
//  AuthViewModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("🥶in")
    }
    
    func createUser(withEmail email: String, password: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, userName: userName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
        } catch {
            print(error.localizedDescription)
        }
        print("🥶")
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
