//
//  WhishlistView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 30/10/23.
//

import SwiftUI

struct WhishlistView: View {
    @State private var isFav = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Whishlist")
                    .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                    .offset(x: -80)
                Spacer()
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 17)
                            .fill(Color("Light").opacity(0.8))
                            .shadow(radius: 5, x: 1, y: 1)
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
                                HStack {
                                    Text("Shoes")
                                        .font(.custom("PlayfairDisplay-Bold", size: 23))
                                    BTHeart(fav: $isFav) {
                                        isFav.toggle()
                                    }
                                    .offset(x: -10,y: 10)
                                }
                                
                                Text("Brand name")
                                    .font(.custom("PlayfairDisplay-Regular", size: 16))
                                Spacer()
                                HStack {
                                    Text("$ 120.00")
                                        .fontWeight(.heavy)
                                    Spacer()
                                    NavigationLink {
                                        CartItemView()
                                    } label: {
                                        CartButton(numberOfProduct: 0, action: {
                                            print("CartButton")
                                        })
                                        .offset(x: -10,y: -11)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.bottom,10)
                    }
                    .padding(8)
                    Spacer()
                }
               
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissView()
                }
            })
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WhishlistView()
}
