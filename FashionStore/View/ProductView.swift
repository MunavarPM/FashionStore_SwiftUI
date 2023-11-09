//
//  ProductView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 11/10/23.
//

import SwiftUI

struct ProductView: View {
    
    @State var isFav: Bool = false
    @State private var isShowCartView = false
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @Environment(\.dismiss) var dismiss
    
    var product: Product
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                    .ignoresSafeArea(.all)
                ScrollView(showsIndicators: false){
                    Image(product.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.top)
                    
                    DescriptionView(product: product)
                        .offset(y: -40)
                    
                    BTHeart(isFav: $isFav, product: product, action: {
                        isFav.toggle()
                        productManagerVM.addToWishlist(product: product)
                    })
                    .padding(.top, -470)
                    .padding(.trailing, 50)
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
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
                MyCart(product: productList[1])
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
    ProductView(product: productList[1])
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
                Text("ModelSH")
                Text("LP")
            }
            .font(.custom("PlayfairDisplay-Bold", size: 20))
            
            HStack(spacing: 2) {
                HStack(spacing: 5) {
                    let rating = product.rating
                    let intRating: Int = Int(rating)
                    let halfStar: Int = rating > Float(intRating) ? 1 : 0
                    var blankStar : Int = rating > Float(intRating) ? 4 - (intRating) : 5 - (intRating)
                    ForEach(0...intRating, id: \.self) { index in
                        RatingStarView(starTypeName: "star.fill")
                    }
                    if halfStar == 1 {
                        RatingStarView(starTypeName: "star.leadinghalf.filled")
                    }
                    ForEach(0...blankStar, id: \.self) { index in
                        RatingStarView(starTypeName: "star")
                    }
                    Text("(\(String(format: "%.1f", rating)))")
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(spacing: 10) {
                    ItemQuantityView(product: product)
                    Text("Available Stock")
                        .fontWeight(.semibold)
                }
            }
            
            Text("Size")
                .font(.custom("PlayfairDisplay-Bold", size: 20))
                .padding(.bottom)
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
                                Group {
                                    Image(systemName: "circle.fill").foregroundColor(.blue)
                                    Image(systemName: "circle.fill").foregroundColor(.black)
                                    Image(systemName: "circle.fill").foregroundColor(.gray)
                                }
                                .font(.title)
                            }
                                
                        }
                    }
                    .frame(width: 80, height: 20)
                }
                .offset(x: -30)
            }
            .offset(y: -9)
            Text("Description")
                .font(.custom("PlayfairDisplay-Bold", size: 20))
            Text("Get a little lift from these Sam Edelman sandals featuring ruched straps and leather lace-up ties, while a braided jute sole makes a fresh statement for summer.")
                .font(.custom("PlayfairDisplay-Regular", size: 12)).opacity(0.6)
                .padding(.top)
            
        }
        .padding()
        .padding(.top)
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
