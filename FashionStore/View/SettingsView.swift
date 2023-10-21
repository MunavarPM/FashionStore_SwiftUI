//
//  SettingsView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 20/10/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State var showHome: Bool = false
    
    var body: some View {
        ZStack {
            Color(Color("Light"))
            VStack {
                Image(.onBoarding1)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                
                Button(action: {}, label: {
                    ZStack {
                        Image(systemName: "pencil.line")
                            .foregroundStyle(.black).font(.footnote).bold()
                    }
                    .padding()
                    .frame(width: 25, height: 25)
                    .background(Color("Light").opacity(0.8))
                    .cornerRadius(7)
                    .shadow(radius: 5)
                        
                })
                .offset(x: 45, y: -30)
                
                HStack {
                    Text(authViewModel.currentUser?.userName ?? User.munavar.userName)
//                    Rectangle()
//                        .frame(width: 100, height: 2)
                }
                
                Button(action: {
                    authViewModel.signOut()
                    showHome = true
                }, label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                            .foregroundStyle(Color("Light"))
                            .font(.caption)
                        Text("LogOut").foregroundStyle(Color("Light"))
                    }
                    .frame(width: UIScreen.main.bounds.width - 200 , height: 50)
                        .background(Color("Dark"))
                        .cornerRadius(30)
                })
                .fullScreenCover(isPresented: $showHome, content: {
                    withAnimation(.easeOut) {
                        Signin()
                    }
                })
            }
        }
    }
}

#Preview {
    SettingsView()
}
