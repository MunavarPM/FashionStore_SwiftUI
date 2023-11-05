//
//  WhishlistView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 30/10/23.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var product: Product
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Wishlist")
                    .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                    .offset(x: -90)
                Spacer()
                SearchBar()
                    .padding(.top)
                VStack {
                    if productManagerVM.wishlistProducts.count > 0 {
                        ForEach(productManagerVM.wishlistProducts, id: \.id){ item in
                            WhishlistCardView(product: item.product)
                                .environmentObject(productManagerVM)
                                .padding(.top, 5)
                        }
                        HStack {
                            Text("Total")
                            Text("\(productManagerVM.wishlistTotal)")
                        }
                    } else {
                        Image("Cart")
                            .resizable()
                            .frame(width: 550, height: 550)
                    }
                    Spacer()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WishlistView(product: productList[0])
        .environmentObject(ProductManagerViewModel())
}

struct WhishlistCardView: View {
    @State private var isFav = false
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var product: Product
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color("Light").opacity(0.8))
                .shadow(radius: 5, x: 1, y: 1)
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
                    HStack {
                        Text(product.suppliers)
                            .font(.custom("PlayfairDisplay-Bold", size: 23))
                        BTHeart(fav: isFav) {
                            isFav.toggle()
                        }
                        .offset(x: -10,y: 10)
                    }
                    
                    Text(product.suppliers)
                        .font(.custom("PlayfairDisplay-Regular", size: 16))
                    Spacer()
                    HStack {
                        Text("\(product.price)")
                            .fontWeight(.heavy)
                        Spacer()
                        Button {
                            print("add to cart")
                            productManagerVM.addtoCart(product: product)
                            print("\(productManagerVM.products.count)✅")
                            productManagerVM.removeFromWishlist(product: product)
                            print("\(productManagerVM.products.count)⚠️")
                        } label: {
                            HStack {
                                Image(systemName: "bag")
                                Text("Add to Cart")
                            }
                            .padding()
                            .frame(width: 150, height: 40)
                            .foregroundStyle(Color("Light"))
                            .background(Color("Dark"))
                            .clipShape(Capsule())
                            .offset(y: -10)
                        }
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
#Preview {
    WhishlistCardView(product: productList[1])
}
