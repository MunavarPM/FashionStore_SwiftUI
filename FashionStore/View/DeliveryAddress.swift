//
//  DeliveryAddress.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 27/10/23.
//

import SwiftUI

struct DeliveryAddress: View {
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
                            ForEach(1..<4, content: { item in
                                ProductListView(image: "OnBoarding"+"\(item)", name: "String", brand: "String", cost: "122")
                            })
                        }
                            
                        Spacer()
                        TotalCostView(cost: 122)
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
    let image: String
    let name: String
    let brand: String
    let cost: String
    
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
                        Image(image)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text("Name-t-shirt")
                                .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                            Text("Brand")
                                .foregroundStyle(.gray)
                                .font(.custom("PlayfairDisplay-Regular", size: 15).bold())
                            Text("$1299")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                        }
                    }
                }
                .offset(x: -60)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.1))
        .padding(.leading)
    }
}
