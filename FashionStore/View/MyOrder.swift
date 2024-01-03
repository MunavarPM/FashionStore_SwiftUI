//
//  CartView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/10/23.
//

import SwiftUI

struct MyOrder: View {
    @EnvironmentObject var orderListVM: ProductManagerViewModel
    @State var onTap: Bool = false
    @State var onGoing: Bool = true
    var product: Product
    var body: some View {
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
                                    onGoing.toggle()
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
                                    onGoing.toggle()
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
                        VStack {
                            ForEach(product.imageName, id: \.self) { img in
                            if onGoing {
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
                                                .frame(width: UIScreen.main.bounds.width, height: 50)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(product.name)
                                            .font(.custom("PlayfairDisplay-Bold", size: 25))
                                        
                                        Text(product.suppliers).opacity(0.5).bold()
                                            .font(.custom("PlayfairDisplay-Bold", size: 18))
                                        HStack {
                                            Text("Quantity:").opacity(0.5)
                                                .font(.custom("PlayfairDisplay-Bold", size: 17))
                                            Text("1").opacity(0.7)
                                        }
                                        HStack {
                                            Text("Size:").opacity(0.5)
                                                .font(.custom("PlayfairDisplay-Bold", size: 17))
                                            Text("S").opacity(0.7)
                                        }
                                    }
                                    Spacer()
                                    Text("$ \(product.price)").bold()
                                        .padding(.horizontal)
                                }
                            } else {
                                Image("Cart")
                                    .resizable()
                                    .frame(width: 550, height: 550)
                                    .padding(.top, 400)
                            }
                        }
                    }
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                DismissView()
            }
//            ToolbarItem(placement: .topBarTrailing) {
//                
//                NavigationLink {
//                    MyCart(product: productList[1], isFav: .constant(false))
//                } label: {
//                    CartButton(numberOfProduct: 1, action: {
//                        print("CartButton")
//                    })
//                }
//            }
        })
        .navigationBarBackButtonHidden(true)
    }
}
 
#Preview {
    MyOrder(onTap: true, product: productList[2])
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
                .foregroundStyle(Color("Dark"))
                .font(.title2)
            
        })
    }
}
