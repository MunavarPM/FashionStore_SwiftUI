//
//  MyCart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyCart: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    //    @StateObject var addressVM = AddressViewModel()
    @EnvironmentObject var addressVM: AddressViewModel
    
    var product: Product
    
    @State private var totalPrice: Double = 0
    @State private var promoCode: String = ""
    @Binding var isFav: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                VStack {
                    ScrollView(showsIndicators: false){
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
                                            ProductView(isFav: $isFav, product: item.product)
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
                    }
                    Spacer()
                    VStack {
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
                                Button(action: {
                                    productManagerVM.removeAllFromCart()
                                }, label: {
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
                        HStack(spacing: 5) {
                            Text("Total")
                                .font(.system(size: 20).bold())
                            Text("(\(productManagerVM.getProductCount(product: product)) item): ").fontWeight(.semibold).font(.system(size: 19))
                                .font(.title2).opacity(0.5)
                                .fontWeight(.bold)
                            Text("$\(productManagerVM.cartTotal)")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        
                        .padding()
                        .frame(width: 360)
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1.5).opacity(0.6).background(Color(red: 0.95, green: 0.95, blue: 0.95))).cornerRadius(15)
                        .padding(3)
                        NavigationLink {
                            DeliveryAddress()
                                .environmentObject(addressVM)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color("Dark"))
                                    .cornerRadius(20)
                            } .overlay {
                                HStack {
                                    Text("Proceed to Pay")
                                        .font(.system(size: 20).bold())
                                        .padding()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.bottom)
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 75)
                    }
                }
                .padding(.bottom, 8)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    MyCart(product: productList[1], isFav: .constant(false))
        .environmentObject(ProductManagerViewModel())
        .environmentObject(AddressViewModel())
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
                ForEach(product.imageName, id: \.self){ img in
                    HStack {
                        if let url = URL(string: img) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .padding()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: UIScreen.main.bounds.width, height: 400)
                            }
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            Text(product.name)
                                .font(.custom("PlayfairDisplay-Bold", size: 23))
                            
                            Text(product.suppliers)
                                .font(.custom("PlayfairDisplay-Regular", size: 16))
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
                }
                .padding(.top)
                .padding(.bottom,10)
            }
            .padding(8)
        }
    }
}
