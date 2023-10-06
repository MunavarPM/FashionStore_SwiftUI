//
//  Signin.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI

struct Signin: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var rotationEffect: Double = 0.0
    @State private var signinToggle: Bool = false
    @State private var conformPassword: String = ""
    var body: some View {
        ZStack {
            Color("Light")
                .ignoresSafeArea()
            VStack {
                /// view
                AppNameView(color: .black)
                    .padding(.bottom, 50)
                    .offset(x: -15)
                VStack(alignment: .leading) {
                    Text(signinToggle ? "Sign Up" : "Welcome !" )
                        .font(.custom("PlayfairDisplay-Bold", size: 25))
                        .padding(.bottom, 5)
                    Text(signinToggle ? "Create an new account" : "please login or sign up to continue with our app")
                        .font(.custom("PlayfairDisplay-Regular", size: 15))
                        .foregroundStyle(.gray)
                        .padding(.bottom, 25)
                    VStack(spacing: 25) {
                        if signinToggle {
                            CustomTF(hint: "Username", value: $username)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                        }
                        CustomTF(hint: "Email", value: $email)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                        CustomTF(hint: "Password",isPassword: true, value: $password)
                            .font(.custom("PlayfairDisplay-Regular", size: 17))
                            .padding(.top, 5)
                        if signinToggle {
                            CustomTF(hint: "Conform Password", isPassword: true, value: $conformPassword)
                                .font(.custom("PlayfairDisplay-Regular", size: 17))
                        }
                        Button {
                            print("Forgot pa{ssword")
                        } label: {
                            Text("Forgot Password?")
                                .font(.custom("PlayfairDisplay-Bold", size: 17))
                                .tint(.black).opacity(0.8)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        Capsule()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                            .overlay {
                                Button {
                                    print("dafsdf")
                                } label: {
                                    Text("Login")
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                        .foregroundStyle(.light)
                                        .padding(.horizontal, 35)
                                        .padding(.vertical, 12)
                                        .background(.dark)
                                        .clipShape(Capsule())
                                        .disabledWithOpacity(signinToggle ? username.isEmpty || email.isEmpty || password.isEmpty || conformPassword.isEmpty : email.isEmpty || password.isEmpty)
                                }
                            }
                        Spacer()
                        
                        HStack {
                            Text(signinToggle ? "Already have an account" :"Don't have an Account?")
                                .font(.custom("PlayfairDisplay-Regular", size: 15))
                            Button {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    signinToggle.toggle()
                                    self.rotationEffect += 180
                                }
                            } label: {
                                Text(signinToggle ? "Signup":"Signin")
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
    }
}

#Preview {
    Signin()
}
