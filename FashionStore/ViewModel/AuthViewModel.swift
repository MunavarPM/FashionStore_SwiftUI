//
//  AuthViewModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var alertTittle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
            print(currentUser?.imagePath ?? "🙄")
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            self.alertTittle = "Uh-oh!"
            self.alertMessage = (error.localizedDescription)
            self.showAlert.toggle()
        }
    }
    
    func createUser(withEmail email: String, password: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, userName: userName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id ?? "").setData(encodedUser)
            await fetchUser()
            
        } catch {
            self.alertTittle = "Uh-oh!"
            self.alertMessage = (error.localizedDescription)
            self.showAlert.toggle()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.alertTittle = "See You Later😊!"
            self.alertMessage = "Thank you for being a part of our community. We'll miss you!👋🏼."
            self.showAlert.toggle()
        } catch {
            self.alertTittle = "Uh-oh!"
            self.alertMessage = (error.localizedDescription)
            self.showAlert.toggle()
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("😎Current User\(String(describing: self.currentUser))")
    }
    
    func reserPassword(email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            self.alertTittle = "Password reset email sent"
            self.alertMessage = ("Check you email inbox for an email to reset you're password 📥")
            self.showAlert.toggle()
        } catch {
            self.alertTittle = "Uh-oh!"
            self.alertMessage = (error.localizedDescription)
            self.showAlert.toggle()
        }
    }
}
