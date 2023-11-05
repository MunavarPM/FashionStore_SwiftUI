//
//  MyCart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyCart: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var product: Product
    
    @State private var totalPrice: Double = 0 
    @State private var promoCode: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                VStack {
                    VStack {
                        HStack {
                            Text("My Cart")
                                .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                                .offset(x: -120)
                        }
                        
                            VStack {
                                if productManagerVM.cartProducts.count > 0 {
                                    ForEach(productManagerVM.cartProducts, id: \.id) { item in
                                        NavigationLink {
                                            ProductView(product: item.product)
                                        } label: {
                                            CartItemView(product: item.product)
                                            /*//                                            .swipeActions {
    //                                                Button {
    //                                                    productManagerVM.removeFromCart(product: item.product)
    //                                                } label: {
    //                                                    Label("", systemImage: "trash")
    //                                                }
    //                                                .tint(.black)
    //                                            }*/
                                        }
                                   }
                                } else {
                                    Image("Cart")
                                        .resizable()
                                        .offset(y: -70)
                                        .frame(width: 550, height: 550)
                                        
                                }
                            }
                        Spacer()
                    }
                    
                    Spacer()
                    HStack {
                        TextField( text: $promoCode, label: {
                            Text("Promo Code")
                        })
                        .padding(.leading)
                        .foregroundColor(.clear)
                        .frame(width: 355, height: 60)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .cornerRadius(10)
                        .overlay {
                            Button(action: {}, label: {
                                Text("Apply")
                                    .bold()
                                    .foregroundStyle(Color("Light"))
                            })
                            .padding(8)
                            .background(Color("Dark"))
                            .cornerRadius(8)
                            .padding(.leading, 260)
                        }
                    }
                    HStack {
                        HStack(spacing: 5) {
                            Text("Total")
                                .font(.custom("PlayfairDisplay-Bold", size: 22))
                            Text("(\(productManagerVM.getProductCount(product: product)) item):").fontWeight(.semibold).font(.title3)
                        }
                        .font(.title2).opacity(0.5)
                        .fontWeight(.bold)
                        Spacer()
                        Text("$\(productManagerVM.cartTotal)")
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
    MyCart(product: productList[1])
        .environmentObject(ProductManagerViewModel())
}

struct CartItemView: View {
    var product: Product
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
                    Image(product.imageName)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .padding()
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.custom("PlayfairDisplay-Bold", size: 23))
                        
                        Text(product.suppliers)
                            .font(.custom("PlayfairDisplay-Regular", size: 16))
                        Spacer()
                        HStack {
                            Text("\(product.price)")
                                .fontWeight(.heavy)
                            Spacer()
                            ItemQuantityView(product: product)
                                .offset(y: -10)
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






