//
//  SettingsView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 20/10/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore


struct ProfileView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    @EnvironmentObject var viewModel: ProductManagerViewModel
    @State private var isDarkMode = false
    @Environment(\.presentationMode) var presentationMode
    @State var showLogin: Bool = false
    @State private var isImageSelected: PhotosPickerItem? = nil
    @State var imageData: Data? = nil
    @State private var userName: String = ""
    @State private var email: String = ""
    @State var retriveImage: [UIImage] = []
    
    var body: some View {
        ZStack {
            Color(Color("Light"))
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("Light").opacity(0.8))
                        .shadow(radius: 15, x: 5, y: 10)
                        .frame(width: 360, height: 120)
                }
                .overlay(
                    HStack {
//                        ForEach(retriveImage, id: \.self) { image in
//                            Image(uiImage: image)
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
//                        }
                        
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                PhotosPicker(selection: $isImageSelected, matching: .images, photoLibrary: .shared()){
                                    Image(systemName: "pencil.line")
                                        .foregroundStyle(.black).font(.footnote).bold()
                                }
                            }
                            .padding()
                            .frame(width: 25, height: 25)
                            .background(Color("Light").opacity(0.8))
                            .cornerRadius(7)
                        })
                        .offset(x: -20, y: 40)
                        
                        VStack(alignment: .leading) {
                            Text(userName)
                                .font(.custom("PlayfairDisplay-Regular", size: 25)).bold()
                            Text(email).opacity(0.4)
                        }
                    }
                        .padding(.horizontal, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
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
                                NavigationLink {} label:{
                                    SettingBTView(imageSF: "person.fill", title: "Personal Details", action: {})
                                }
                                NavigationLink {
                                    ForEach(viewModel.orderList, id: \.id) { prodcut in
                                        MyOrder(product: prodcut.product)
                                    }
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
                    }, label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                                .foregroundStyle(Color("Light"))
                                .font(.caption)
                            Text("LogOut").foregroundStyle(Color("Light"))
                        }
                        .alert(isPresented: $authViewModel.showAlert) {
                            Alert(
                                title: Text(authViewModel.alertTittle),
                                message: Text(authViewModel.alertMessage),
                                dismissButton: .default(
                                    Text("OK"),
                                    action: {
                                        showLogin = true
                                    }
                                )
                            )
                        }
                        .frame(width: UIScreen.main.bounds.width - 23, height: 50)
                        .background(Color("Dark"))
                        .cornerRadius(17)
                        .padding()
                    })
                }
                .fullScreenCover(isPresented: $showLogin, content: {
                    withAnimation(.easeOut) {
                        Signin()
                        
                    }
                })
                
            }
            
            .onAppear {
                guard let auth = try? authViewModel.getAuthUser() else { return }
                let path = "product_image/\(CodingKeys.jacket).jpg"
                userName = auth.userName ?? auth.id ?? ""
                email = auth.email ?? ""
                print("\(auth)userrrrrrr!")
                let data = StorageManager.shared.productCollection(imageRef: path)
                print(data)
                print(imageData ?? "no data")
                print("✅\(retriveImage)")
            }
            .task {
                if (authViewModel.currentUser != nil),
                   let path = authViewModel.currentUser?.imagePath {
                    let data = try? await StorageManager.shared.getData(path: path)
                    self.imageData = data
                    
                }
            }
            .onChange(of: isImageSelected) { value in
                if let value {
                    viewModel.saveProductImage(item: value, parent: "shoes")
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
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

