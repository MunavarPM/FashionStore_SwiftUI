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
    
//    @AppStorage("user_name") private var userName: String = ""
//    @AppStorage("user_UID")private var userUID: String = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String, password: String) async throws {
        print("🥶in")
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("😿in signIn\(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, userName: userName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
            await fetchUser()
            
        } catch {
            print("Error in CreatingUser\(error.localizedDescription)")
        }
        print("🥶")
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Enrror in the signOut👋🏼\(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("😎Current User\(self.currentUser)")
//        await MainActor.run(body: {
//            currentUser = snapshot
//            //MARK: here i used it to give initial value to userName,userUID,profileURL from user fullname , id , profileurl
//            self.userName = snapshot.userName
//            self.userUID = snapshot.id
//        })
    }
    func reserPassword(email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("Error of SendReset Password\(error.localizedDescription)")
        }
    }
}
