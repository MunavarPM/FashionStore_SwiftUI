//
//  MyCart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyCart: View {
    let cartList = ["Antoine", "Bas", "Curt", "Dave", "Erica"]
    
    
    @State private var totalPrice: Double = 0 // You may want to compute the total price based on the items in the cart
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                VStack {
                    VStack {
                        Text("My Cart")
                            .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                            .offset(x: -120)
                        Spacer()
                        List {
                            ForEach(0 ..< 2, id: \.self) { item in
                                CartItemView()
                                    .swipeActions {
                                        Button {
                                            // Handle the removal of the item from the cart
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.black)
                                    }
                            }
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                    HStack {
                        HStack {
                            Text("Total")
                                .font(.custom("PlayfairDisplay-Bold", size: 25))
                            Text("(3 item):").fontWeight(.bold).font(.title2)
                        }
                            .font(.title2).opacity(0.5)
                            .fontWeight(.bold)
                        Spacer()
                        Text("$250")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding()
                    NavigationLink {
                        DeliveryAddress()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color("Dark"))
                                .cornerRadius(20)
                        } .overlay {
                            HStack {
                                Text("Proceed to Pay")
                                    .font(.custom("PlayfairDisplay-Bold", size: 25))
                                    .padding(.leading, 30)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                Spacer()
                                Image(systemName: "arrowshape.forward.fill")
                                    .padding(6)
                                    .foregroundStyle(Color("Dark"))
                                    .background(Color("Light"))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 15)
                            }
                        }
                        .padding(.bottom)
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 75)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    MyCart()
}

struct CartItemView: View {
    var body: some View {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 17)
                        .fill(Color("Light").opacity(0.8))
                        .shadow(radius: 5, x: 2, y: 5)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 110)
                }
                .overlay {
                    HStack {
                        Image(.shoesBoys)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Shoes")
                                .font(.custom("PlayfairDisplay-Bold", size: 23))
                            
                            Text("Brand name")
                                .font(.custom("PlayfairDisplay-Regular", size: 16))
                            Spacer()
                            HStack {
                                Text("$ 120.00")
                                    .fontWeight(.heavy)
                                Spacer()
                                ItemQuantityView()
                            }
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom,10)
                }
                .padding(8)
        }
    }
}


