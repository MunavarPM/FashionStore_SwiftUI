//
//  SettingsView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 20/10/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State var showHome: Bool = false
    @State private var isDarkMode = false
    
    var body: some View {
        ZStack {
            Color(Color("Light"))
            
        NavigationStack {
                VStack {
                    ShadowView(name: authViewModel.currentUser?.userName ?? User.munavar.userName, email: authViewModel.currentUser?.email ?? User.munavar.email)
                        .padding(.top)
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color("Light").opacity(0.8))
                                    .frame(width: 360, height: 350)
                            }
                            .overlay {
                                VStack {
                                    NavigationLink {
                                    MyOrder()
                                    } label:{
                                        SettingBTView(imageSF: "person.fill", title: "Personal Details", action: {})
                                    }
                                    NavigationLink {
                                        MyOrder()
                                    } label: {
                                        SettingBTView(imageSF: "bag.fill", title: "My Order", action: {})
                                    }
                                    NavigationLink {
                                        DeliveryAddress()
                                    } label: {
                                        SettingBTView(imageSF: "box.truck.fill", title: "Shipping Address", action: {})
                                    }
                                    NavigationLink {
                                        
                                    } label: {
                                        SettingBTView(imageSF: "creditcard.fill", title: "My Card", action: {})
                                    }
                                    HStack(spacing: 20) {
                                        Rectangle()
                                            .fill(Color.gray)
                                            .opacity(0.3)
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                            .overlay(
                                                HStack {
                                                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                                        .resizable()
                                                        .frame(width: 27, height: 25)
                                                }
                                            )
                                        Text("Dark Mode")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20))
                                        Spacer()
                                        Toggle("", isOn: $isDarkMode)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2).opacity(0.5))
                            .padding(35)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color("Light").opacity(0.8))
                                    .frame(width: 360, height: 215)
                            }
                            .overlay {
                                VStack {
                                    SettingBTView(imageSF: "exclamationmark.octagon.fill", title: "FAQs", action: {})
                                    SettingBTView(imageSF: "checkmark.shield.fill", title: "Privacy Policy", action: {
                                        print("Order Details")
                                    })
                                    SettingBTView(imageSF: "gear", title: "Settings", action: {})
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 2).opacity(0.5))
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
                            .frame(width: UIScreen.main.bounds.width - 23, height: 50)
                            .background(Color("Dark"))
                            .cornerRadius(17)
                            .padding()
                        })
                    }
                    
                    
                    .fullScreenCover(isPresented: $showHome, content: {
                        withAnimation(.easeOut) {
                            Signin()
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

struct ShadowView: View {
    let name: String?
    let email: String?
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Light").opacity(0.8))
                .shadow(radius: 15, x: 5, y: 10)
                .frame(width: 360, height: 120)
        }
        .overlay(
            HStack {
                Image(.onBoarding1)
                    .resizable()
                    .frame(width: 90, height: 90)
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
                })
                .offset(x: -20, y: 40)
                
                VStack(alignment: .leading) {
                    Text(name ?? "")
                        .font(.custom("PlayfairDisplay-Regular", size: 25)).bold()
                    Text(email ?? "").opacity(0.4)
                }
            }
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
        )
    }
}

struct SettingBTView: View {
    let imageSF: String
    let title: String
    let action: () -> Void
    var body: some View {
        HStack(spacing: 20) {
            Rectangle()
                .fill(Color.gray)
                .opacity(0.3)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
                .padding(.horizontal)
                .overlay(
                    HStack {
                        Image(systemName: imageSF)
                            .resizable()
                            .frame(width: 27, height: 25)
                    }
                )
            Text(title)
                .font(.custom("PlayfairDisplay-Bold", size: 20))
            Spacer()
            Button(action: action, label: {
                Image(systemName: "chevron.forward")
                    .font(.subheadline)
                    .padding()
            })
        }
        .onTapGesture {
            action()
        }
    }
}

