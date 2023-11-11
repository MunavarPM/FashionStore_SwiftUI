//
//  Signin.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI
import Firebase

struct Signin: View {
    
    @FocusState private var emailIsFoucused: Bool
    @StateObject var authViewModel = AuthViewModel()
    @State var rotationEffect: Double = 0.0
    @ObservedObject var viewModel = LoginRegisterViewModel()
    
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
                    Text(viewModel.signinToggle ?  "Welcome !" : "Sign Up")
                        .font(.custom("PlayfairDisplay-Bold", size: 25))
                        .padding(.bottom, 5)
                    Text(viewModel.signinToggle ?  "please login or sign up to continue with our app" : "Create an new account")
                        .font(.custom("PlayfairDisplay-Regular", size: 15))
                        .foregroundStyle(.gray)
                        .padding(.bottom, 25)
                    VStack(spacing: 25) {
                        if !viewModel.signinToggle {
                            CustomTF(hint: "Username", value: $viewModel.username)
                                .autocapitalization(.none)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                        }
                        CustomTF(hint: "Email", value: $viewModel.email)
                            .autocapitalization(.none)
                            .focused($emailIsFoucused)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                            .textContentType(.emailAddress)
                        CustomTF(hint: "Password",isPassword: true, value: $viewModel.password)
                            .autocapitalization(.none)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                            .padding(.top, 5)
                        if !viewModel.signinToggle {
                            CustomTF(hint: "Conform Password", isPassword: true, value: $viewModel.conformPassword)
                                .autocapitalization(.none)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                        }
                        if viewModel.signinToggle {
                            Button {
                                Task {
                                    await authViewModel.reserPassword(email: viewModel.email)
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
                                        do {
                                            if viewModel.signinToggle {
                                                try await authViewModel.signIn(withEmail: viewModel.email, password: viewModel.password)
                                            } else {
                                                try await authViewModel.createUser(withEmail: viewModel.email, password: viewModel.password, userName: viewModel.username)
                                            }
                                        } catch {
                                            print("😿 Button of login and signin\(error.localizedDescription)")
                                            authViewModel.showAlert.toggle()
                                            self.authViewModel.alertMessage = error.localizedDescription
                                            self.authViewModel.alertTittle = "⚠️"
                                        }
                                    }
                                } label: {
                                    Text(viewModel.signinToggle ? "Login" : "Submit")
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                        .foregroundStyle(.light)
                                        .padding(.horizontal, 35)
                                        .padding(.vertical, 12)
                                        .background(.dark)
                                        .clipShape(Capsule())
                                        .disabledWithOpacity( viewModel.email.isEmpty || viewModel.password.isEmpty)
                                }
                                .onAppear {
                                    Auth.auth().addStateDidChangeListener { auth, user in
                                        if user != nil {
                                            viewModel.showHome.toggle()
                                        }
                                    }
                                }
                            }
                        
                        Spacer()
                        
                        HStack {
                            Text(viewModel.signinToggle ? "Don't have an Account?" :  "Already have an account")
                                .font(.custom("PlayfairDisplay-Regular", size: 15))
                            Button {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    viewModel.signinToggle.toggle()
                                    self.rotationEffect += 180
                                }
                            } label: {
                                Text(viewModel.signinToggle ? "Sign up" : "Sign in")
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
            .alert(isPresented: $authViewModel.showAlert) {
                Alert(title: Text(authViewModel.alertTittle), message: Text(authViewModel.alertMessage), dismissButton: .cancel())
        }
        .rotation3DEffect(Angle(degrees: rotationEffect), axis: (x: 0.0, y: 5.0, z: 0.0))
        
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.emailIsFoucused = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.showHome, content: {
            withAnimation(.easeIn) {
                TabBar()
            }
        })
    }
}

#Preview {
    Signin()
}
