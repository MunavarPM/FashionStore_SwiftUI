//
//  Signin.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI
import Firebase

struct Signin: View {
    
    //    @ObservedObject var authViewModel = AuthViewModel()
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var conformPassword: String = ""
    @State private var rotationEffect: Double = 0.0
    @State private var signinToggle: Bool = true
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var alertTittle: String = ""
    @State var showAlert: Bool = false
    @State var showHome: Bool = false

    
    @StateObject var authViewModel = AuthViewModel()
    
    
    var body: some View {
        //        if authViewModel.isAuthenticated {
        //            HomeView()
        //        } else {
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
                        CustomTF(hint: "Email", value: $email)
                            .autocapitalization(.none)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                            .autocapitalization(.none)
                        CustomTF(hint: "Password",isPassword: true, value: $password)
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
                                Task {
                                    await authViewModel.reserPassword(email: email)
                                }
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
//                                        /*do {
//                                            if !signinToggle {
//                                                try await authViewModel.createUser(withEmail: Email, password: Password, userName: username)
//                                            } else {
//                                                try await
//                                                authViewModel.signIn(withEmail: email, password: password)
//                                            }
//                                        } catch {
//                                            showAlert.toggle()
//                                            self.alertMessage = error.localizedDescription
//                                        }*/
                                        
                                        do {
                                            if signinToggle {
                                                try await authViewModel.signIn(withEmail: email, password: password)
                                            } else {
                                                try await authViewModel.createUser(withEmail: email, password: password, userName: username)
                                            }
                                        } catch {
                                            print("😿 Button of login and signin\(error.localizedDescription)")
                                            showAlert.toggle()
                                            self.alertMessage = error.localizedDescription
                                            self.alertTittle = "⚠️"
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
                                        .disabledWithOpacity( email.isEmpty || password.isEmpty)
                                }
                                .onAppear {
                                    Auth.auth().addStateDidChangeListener { auth, user in
                                        if user != nil {
                                            showHome.toggle()
                                        }
                                    }
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
                                Text(signinToggle ? "Sign up" : "Sign in")
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTittle), message: Text(alertMessage), dismissButton: .cancel())
        }
        .rotation3DEffect(Angle(degrees: rotationEffect), axis: (x: 0.0, y: 5.0, z: 0.0))
        
        }
        .fullScreenCover(isPresented: $showHome, content: {
            withAnimation(.easeIn) {
                TabBar()
            }
        })
    }
}
//    func register() {
//        /// Linking the firebase when tap the button
//        Task {
//            do {
//                //                isLoading = true
//                try await authViewModel.signUp(signUpData: SignUpDataModel(username: username, email: email, password: password))
//                //                isLoggedIn = true
//                //                isLoading = false
//            } catch {
//                alertMessage = error.localizedDescription
//            }
//        }
//    }
//}

#Preview {
    Signin()
}
