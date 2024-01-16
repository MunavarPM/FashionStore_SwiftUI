//
//  DeliveryAddress.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 27/10/23.
//

import SwiftUI

struct DeliveryAddress: View {
    
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @EnvironmentObject var addressVM: AddressViewModel
//    @StateObject var addressVM: AddressViewModel = AddressViewModel()
    
    @State var showRazorPayView =  false
    
    @State var showAddAddressView = false
    @State var enableEditAddress = false
    @State var tappedAddress = AddressModel()
    
    var body: some View {
            ForEach(0..<addressVM.addressArray.count) { each in
                let element = addressVM.addressArray[each]
                ZStack {
                    Color("AccentColor").ignoresSafeArea(.all)
                    VStack {
                        Text("Delivery Address")
                            .foregroundStyle(Color("AccentColor2"))
                            .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                            .offset(x: -60)
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("AccentColor").opacity(0.1))
                                    .frame(width: 360, height: 280)
                                    .shadow(radius: 5, x: 5, y: 5)
                            }
                            .overlay {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Name: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.name)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    HStack {
                                        Text("BuildingName: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.buildingName)" as String)
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                        
                                    }
                                    HStack {
                                        Text("Land Mark: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.landmark)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    HStack {
                                        Text("Street: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.street)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    HStack {
                                        Text("City, State: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.city),\(element.state)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    
                                    HStack {
                                        Text("Country: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.country)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    HStack {
                                        Text("Phone Number 1: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.phoneNumber1)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                    HStack {
                                        Text("Phone Number 2: ")
                                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                            .foregroundStyle(Color("AccentColor2"))
                                        Text("\(element.phoneNumber2)")
                                            .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.5))
                        .padding()
                        .padding(.leading, 0)
                        
                        Text("Product List")
                            .font(.custom("PlayfairDisplay-Regular", size: 26).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        ScrollView(showsIndicators: false){
                            ForEach(productManagerVM.cartProducts) { item in
                                ProductListView(product: item.product)
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            NavigationLink {
                                Payment()
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("Total Price")
//                                        .foregroundStyle(Color("AccentColor2"))
                                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                                        .opacity(0.4)
                                    Text("$\(productManagerVM.cartTotal)")
//                                        .foregroundStyle(Color("AccentColor2"))
                                        .font(.title)
                                        .fontWeight(.heavy)
                                }
                                .foregroundStyle(Color("AccentColor2"))
                            }
                            Spacer()
                            NavigationLink {
                                RazorPayView(productManagerViewModel: productManagerVM, totalPrice: productManagerVM.cartTotal)
                            } label: {
                                HStack {
                                    Image(systemName: "bag")
                                    Text("Place Order")
                                }
                                .padding(15)
                                .foregroundStyle(Color("AccentColor"))
                                .background(Color("AccentColor2"))
                                .clipShape(Capsule())
                            }
                        }
                        .padding()
                        .padding(.horizontal, 10)
                    }
                }
                
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DismissView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddAddressView = true
                            enableEditAddress = true
//                            tappedAddress = each
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.caption)
                                .padding(7)
                                .foregroundStyle(Color("Dark"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.black, lineWidth: 1)
                                        .fill(Color("AccentColor2"))
                                )
                                .padding()
                        }
                    }
                })
                .sheet(isPresented: $showAddAddressView) {
                    AddressEditing(addressViewModel: AddressViewModel(), enableEditAddress: $enableEditAddress, showAddAddressView: $showAddAddressView, tappedAddress: $tappedAddress)
                }
            }
    }
}

#Preview {
    DeliveryAddress()
        .environmentObject(AddressViewModel())
        .environmentObject(ProductManagerViewModel())
}

struct ProductListView: View {
    
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Light").opacity(0.1))
                    .frame(width: 320, height: 75)
                    .shadow(radius: 5, x: 5, y: 5)
                
            }
            .overlay {
                VStack {
                    HStack(spacing: 20) {
                        ForEach(product.imageName, id: \.self){ image in
                            if let url = URL(string: image) {
                                AsyncImage(url: url) { img in
                                    img
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                                .foregroundStyle(Color("AccentColor2"))
                            Text(product.suppliers)
                                .foregroundStyle(.gray)
                                .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                            Text("$\(product.price)")
                                .foregroundStyle(Color("AccentColor2"))
                                .font(.title3)
                                .fontWeight(.bold)
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            productManagerVM.cartProducts
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.5))
        .padding(.leading)
    }
}
