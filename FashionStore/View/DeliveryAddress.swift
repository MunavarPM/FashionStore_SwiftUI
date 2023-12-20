//
//  DeliveryAddress.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 27/10/23.
//

import SwiftUI

struct DeliveryAddress: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light").ignoresSafeArea(.all)
                VStack {
                    Text("Delivery Address")
                        .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                        .offset(x: -60)
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Light").opacity(0.1))
                                .frame(width: 360, height: 280)
                                .shadow(radius: 5, x: 5, y: 5)
                        }
                        .overlay {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Street: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("City: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                    
                                }
                                HStack {
                                    Text("State/Province/area: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("Phone Number: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("Zip Code: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("Country calling code: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                                HStack {
                                    Text("Country: ")
                                        .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                                    Text("India")
                                        .font(.custom("PlayfairDisplay-Regular", size: 18).bold())
                                        .foregroundStyle(.gray)
                                }
                            }
                            .offset(x: -40)
                        }
                        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.1))
                        .padding()
                        .padding(.leading, 0)
                        
                        Text("Product List")
                            .font(.custom("PlayfairDisplay-Regular", size: 26).bold())
                            .padding(.leading)
                        ScrollView(showsIndicators: false){
                            
                                ForEach(productManagerVM.cartProducts, id: \.id) { item in
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
                                        .foregroundStyle(Color("Dark"))
                                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                                        .opacity(0.4)
                                    Text("$\(1222)")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                    
                                }
                                .foregroundStyle(Color("Dark"))
                            }
                            Spacer()
                            NavigationLink {
                                Payment()
                            } label: {
                                HStack {
                                    Image(systemName: "bag")
                                    Text("Place Order")
                                }
                                .padding(15)
                                .foregroundStyle(Color("Light"))
                                .background(Color("Dark"))
                                .clipShape(Capsule())
                            }
                        }
                        .padding()
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissView()
                }
            })
        }
    }
}

#Preview {
    DeliveryAddress()
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
                            Text(product.suppliers)
                                .foregroundStyle(.gray)
                                .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                            Text("$\(product.price)")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                        }
                    }
                }
                .offset(x: -70)
            }
        }
        .onAppear {
            productManagerVM.cartProducts
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.1))
        .padding(.leading)
    }
}
