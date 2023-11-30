//
//  ProductView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 11/10/23.
//

import SwiftUI

struct ProductView: View {
    
    @Binding var isFav: Bool
    @State private var isShowCartView = false
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @Environment(\.dismiss) var dismiss
    
    var product: Product
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                    .ignoresSafeArea(.all)
                ScrollView {
                    VStack {
                        Image(product.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.top)
                            .overlay(alignment: .bottomTrailing) {
                                BTHeart(isFav: isFav, product: product) {
                                    isFav.toggle()
                                }
                                .padding(30)
                            }
                        
                        DescriptionView(product: product)
                    }
                    
                }
//                .onAppear {
//                    UIScrollView.appearance().bounces = false
//                }
                .edgesIgnoringSafeArea(.top)
            }
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                TotalCostView(cost: product.price, text: "Add to Cart", product: product)
                    .background(RoundedRectangle(cornerRadius: 35).fill(.ultraThinMaterial).frame(width: 380, height: 88))
                    .padding(.horizontal, 25)
                    .padding(.bottom, 5)
                    .offset(y: 20)
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton(numberOfProduct: productManagerVM.cartProducts.count, action: {
                        isShowCartView.toggle()
                    })
                }
            }
        }
        .sheet(isPresented: $isShowCartView, content: {
            NavigationStack {
                MyCart(product: productList[1], isFav: .constant(false))
                    .environmentObject(productManagerVM)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print(productManagerVM.products.count)
                                isShowCartView = false // Set this to dismiss the sheet
                            } label: {
                                DismissView()
                                    .offset(x: -7, y: 15)
                            }
                        }
                    }
            }
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProductView(isFav: .constant(true), product: productList[3])
        .environmentObject(ProductManagerViewModel())
}

struct DescriptionView: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @State private var selectedProduct: Product?
    @State var isOption: Bool = false
    var product: Product
    let sizeArray: [String] = ["S", "M", "L"]
    
    var body: some View {
            VStack(alignment: .leading, spacing: 1) {
                Group {
                    Text(product.name)
                    Text(product.suppliers)
                }
                .font(.custom("PlayfairDisplay-Bold", size: 20))
                
                HStack(spacing: 0) {
                    HStack(spacing: 5) {
                        let rating = product.rating
                        let intRating: Int = Int(rating)
                        let hasHalfStar: Bool = rating > Float(intRating)
                        
                        ForEach(0..<5) { index in
                            if index < intRating {
                                RatingStarView(starTypeName: "star.fill")
                            } else if hasHalfStar, index == intRating {
                                RatingStarView(starTypeName: "star.leadinghalf.filled")
                            } else {
                                RatingStarView(starTypeName: "star")
                            }
                        }
                        
                        Text("(\(String(format: "%.1f", rating)))")
                            .foregroundColor(.gray)
                    }
                    .offset(y: -18)
                    Spacer()
                    VStack(spacing: 10) {
                        ItemQuantityView(product: product)
                        Text("Available Stock")
                            .fontWeight(.semibold)
                    }
                }
                
                Text("Size")
                    .font(.custom("PlayfairDisplay-Bold", size: 20))
                    .offset(y: -20)
                HStack {
                    ForEach(sizeArray,id: \.self) { size in
                        Text("\(size)")
                            .bold()
                            .padding()
                            .background {
                                Circle().fill(.ultraThinMaterial)
                            }
                    }
                    Spacer()
                    VStack {
                        ForEach(product.colors) { color in
                            HStack {
                                Text("Colour's").bold()
                                    .font(.custom("PlayfairDisplay-Bold", size: 20))
                                    .onTapGesture {
                                        isOption.toggle()
                                    }
                                if isOption {
                                    ColorDotView(color: .blue)
                                    ColorDotView(color: .green)
                                    ColorDotView(color: .black)
                                }
                            }
                        }
                        .frame(width: 80, height: 20)
                    }
                    .padding()
                }
                .offset(y: -9)
                Text("Description")
                    .font(.custom("PlayfairDisplay-Bold", size: 20))
                Text(product.discription)
                    .font(.custom("PlayfairDisplay-Regular", size: 12)).opacity(0.6)
                    .padding(.top, 5)
            }
            .padding()
            .padding(.bottom, 85)
            .background(Color("Light"))
            .cornerRadius(40)
    }
}

struct TotalCostView: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    let cost: Int
    let text: String
    var product: Product
    var body: some View {
        HStack {
            NavigationLink {
                Payment()
            } label: {
                VStack(alignment: .leading) {
                    Text("Total Price")
                        .foregroundStyle(Color("Dark"))
                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                        .opacity(0.4)
                    Text("$\(cost)")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                }
                .foregroundStyle(Color("Dark"))
            }
            Spacer()
            Button {
                productManagerVM.addtoCart(product: product)
                print(productManagerVM.products.count)
            } label: {
                HStack {
                    Image(systemName: "bag")
                    Text(text)
                }
                .padding(15)
                .foregroundStyle(Color("Light"))
                .background(Color("Dark"))
                .clipShape(Capsule())
            }
        }
    }
}

struct ItemQuantityView: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var product: Product
    var body: some View {
        HStack {
            let productTotal = productManagerVM.getProductCount(product: product)
            Button {
                productManagerVM.addToWishlist(product: product)
                productManagerVM.addtoCart(product: product)
            } label: {
                Image(systemName: "plus")
                    .font(.footnote)
            }
            
            Text("\(productTotal)")
            
            if productTotal == 1 {
                Image(systemName: "trash")
                    .foregroundStyle(.black)
                    .onTapGesture {
                        productManagerVM.removeFromCart(product: product)
                    }
            } else {
                Image(systemName: "minus")
                    .foregroundStyle(.black)
                    .onTapGesture {
                        productManagerVM.minusProductCart(product: product)
                }
            }
        }
        .padding(.horizontal, 4)
        .padding(10)
        .foregroundStyle(.black)
        .background(RoundedRectangle(cornerRadius: 30).fill(.ultraThinMaterial))
    }
}
struct RatingStarView: View {
    var starTypeName: String
    var body: some View {
        HStack {
            Image(systemName: starTypeName)
                .resizable()
                .frame(width: 20,height: 20)
                .foregroundColor(.yellow)
        }
    }
}
struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 25, height: 25)
            .clipShape(Circle())
    }
}
