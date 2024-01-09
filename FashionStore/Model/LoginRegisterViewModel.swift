//
//  LoginRegisterViewModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 11/11/23.
//

import SwiftUI

class LoginRegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var conformPassword: String = ""
    @Published var signinToggle: Bool = true
    @Published var isLoading: Bool = false
    @Published var alertMessage: String = ""
    @Published var showLogin: Bool = false
    
    func clearPassword() {
        password = ""
    }
}


