//
//  MyCart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyCart: View {
    let cartList = ["Antoine", "Bas", "Curt", "Dave", "Erica"]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                VStack {
                    Text("My Cart")
                        .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                        .offset(x: -120)
                    Spacer()
                    List {
                        ForEach(0 ..< 5, id: \.self) { item in
                                CartItemView()
                                .swipeActions {
                                    Button {
                                        
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(.black)
                                }
                        }
                    }
                    
                    .listStyle(.plain)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                withAnimation(.easeOut){
                                    dismiss()
                                }
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title)
                            })
                        }
                    })
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
                        .frame(width: UIScreen.main.bounds.width - 30, height: 120)
                }
                .overlay {
                    HStack {
                        Image(.shoesBoys)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Shoes")
                                .font(.custom("PlayfairDisplay-Bold", size: 25))
                            
                            Text("Brand name")
                                .font(.custom("PlayfairDisplay-Regular", size: 18))
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
