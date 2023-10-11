//
//  Signin.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI

struct Signin: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var rotationEffect: Double = 0.0
    @State private var signinToggle: Bool = true
    @State private var conformPassword: String = ""
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var alertTittle: String = ""
    @State var showAlert: Bool = false
    @State private var Email: String = ""
    @State private var Password: String = ""
    
    
    var body: some View {
        if authViewModel.isAuthenticated {
            HomeView()
        } else {
            ZStack {
                Color("Light")
                    .ignoresSafeArea()
                VStack {
                    AppNameView(color: .black)
                        .padding(.bottom, 50)
                        .offset(x: -15)
                    VStack(alignment: .leading) {
                        Text(signinToggle ?  "Welcome !" : "Sign Up")
                            .font(.custom("PlayfairDisplay-Bold", size: 25))
                            .padding(.bottom, 5)
                        Text(signinToggle ?  "please login or sign up to continue with our app" : "Create an new account")
                            .font(.custom("PlayfairDisplay-Regular", size: 15))
                            .foregroundStyle(.gray)
                            .padding(.bottom, 25)
                        VStack(spacing: 25) {
                            if !signinToggle {
                                CustomTF(hint: "Username", value: $username)
                                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                                    .autocapitalization(.none)
                            }
                            CustomTF(hint: "Email", value: signinToggle ?  $email : $Email)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                                .autocapitalization(.none)
                            CustomTF(hint: "Password",isPassword: true, value: signinToggle ? $password : $Password)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                                .autocapitalization(.none)
                                .padding(.top, 5)
                            if !signinToggle {
                                CustomTF(hint: "Conform Password", isPassword: true, value: $conformPassword)
                                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                                    .autocapitalization(.none)
                            }
                            if signinToggle {
                                Button {
                                    print("Forgot pa{ssword")
                                } label: {
                                    Text("Forgot Password?")
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                        .tint(.black).opacity(0.8)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            Capsule()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                                .overlay {
                                    Button {
                                        Task {
                                            do {
                                                if !signinToggle {
                                                    try await authViewModel.signUp(signUpData: SignUpDataModel(username: username, email: email, password: password))
                                                } else {
                                                    try await authViewModel.signIn(email: email, password: password)
                                                }
                                            } catch {
                                                // Handle any errors here, such as displaying an error message to the user.
                                            }
                                        }
                                    } label: {
                                        Text(signinToggle ? "Login" : "Submit")
                                            .font(.custom("PlayfairDisplay-Bold", size: 17))
                                            .foregroundStyle(.light)
                                            .padding(.horizontal, 35)
                                            .padding(.vertical, 12)
                                            .background(.dark)
                                            .clipShape(Capsule())
                                            .disabledWithOpacity(signinToggle ? email.isEmpty || password.isEmpty : username.isEmpty || Email.isEmpty || Password.isEmpty || conformPassword.isEmpty )
                                    }
                                    .alert(alertMessage, isPresented:$showAlert, actions: {})
                                }
                            Spacer()
                            
                            HStack {
                                Text(signinToggle ? "Don't have an Account?" :  "Already have an account" )
                                    .font(.custom("PlayfairDisplay-Regular", size: 15))
                                Button {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        signinToggle.toggle()
                                        self.rotationEffect += 180
                                    }
                                } label: {
                                    Text(signinToggle ? "Signin" : "Signup")
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                        .fontWeight(.bold)
                                        .tint(.black)
                                }
                                .font(.callout)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                }
                .rotation3DEffect(Angle(degrees: rotationEffect), axis: (x: 0.0, y: 5.0, z: 0.0))
            }
            .rotation3DEffect(Angle(degrees: rotationEffect), axis: (x: 0.0, y: 5.0, z: 0.0))
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTittle), message: Text(alertMessage), dismissButton: .cancel())
            }
        }
    }
    func register() {
        /// Linking the firebase when tap the button
        Task {
            do {
                //                isLoading = true
                try await authViewModel.signUp(signUpData: SignUpDataModel(username: username, email: email, password: password))
                //                isLoggedIn = true
                //                isLoading = false
            } catch {
                alertMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    Signin()
}
