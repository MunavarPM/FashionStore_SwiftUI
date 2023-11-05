//
//  CartView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyOrder: View {
    @State var onTap: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Order")
                    .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                    .offset(x: -105)
                Spacer()
                ScrollView(showsIndicators: false) {
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(onTap ? Color("Light") : Color("Dark").opacity(0.8))
                                .frame(width: 100, height: 40)
                        }
                        .overlay {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    onTap.toggle()
                                }
                            }, label: {
                                Text("Ongoing")
                                    .foregroundStyle(onTap ? Color("Dark") : Color("Light"))
                            })
                        }
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2).opacity(0.5))
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(onTap ? Color("Dark") : Color("Light").opacity(0.8))
                                .frame(width: 100, height: 40)
                        }
                        .overlay {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    onTap.toggle()
                                }
                            }, label: {
                                Text("Completed")
                                    .foregroundStyle(onTap ? Color("Light") : Color("Dark"))
                            })
                        }
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2).opacity(0.5))
                        
                    }
                    .padding(10)
                    .padding(.horizontal)
                    .padding(.top,0)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Light").opacity(0.8))
                            .shadow(radius: 10, x: 5, y: 10)
                            .frame(width: UIScreen.main.bounds.width - 25, height: 120)
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
                                    .font(.custom("PlayfairDisplay-Bold", size: 25))
                                
                                Text("Brand name").opacity(0.5).bold()
                                    .font(.custom("PlayfairDisplay-Bold", size: 18))
                                HStack {
                                    Text("Quantity:").opacity(0.5)
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                    Text("2").opacity(0.7)
                                }
                                HStack {
                                    Text("Size:").opacity(0.5)
                                        .font(.custom("PlayfairDisplay-Bold", size: 17))
                                    Text("42").opacity(0.7)
                                }
                            }
                            Spacer()
                            Text("$ 120.00").bold()
                                .padding(.horizontal)
                        }
                    }
                }
            }
            
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        DismissView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        NavigationLink {
                            MyCart(product: productList[1])
                        } label: {
                            CartButton(numberOfProduct: 1, action: {
                                print("CartButton")
                            })
                        }
                    }
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyOrder(onTap: true)
}
struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            withAnimation(.easeOut){
                dismiss()
            }
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
        })
    }
}
