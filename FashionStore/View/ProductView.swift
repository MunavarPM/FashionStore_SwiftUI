//
//  ProductView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 11/10/23.
//

import SwiftUI

struct ProductView: View {
    
    @State private var isFav = false
    @Environment(\.dismiss) var dismiss
    var product: Product
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                    .ignoresSafeArea(.all)
                ScrollView(showsIndicators: false){
                    Image(product.image1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.top)
                    
                    
                    DescriptionView()
                        .offset(y: -40)
                    BTHeart(fav: $isFav, action: {
                        
                    })
                    .offset(x: -30, y: -550)
                }
                .edgesIgnoringSafeArea(.top)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissView()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton(numberOfProduct: 1, action: {
                        print("CartButton")
                    })
                }
            }
        }
    }
}

#Preview {
    ProductView(product: productList[2])
}

struct DescriptionView: View {
    let sizeArray: [String] = ["S", "M", "L"]
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Group {
                Text("ModelSH")
                Text("LP")
            }
            .font(.custom("PlayfairDisplay-Bold", size: 20))
            
            HStack(spacing: 4) {
                ForEach(0..<5){ item in
                    Image(.star)
                }
                .offset(y: -9)
                Text("(320 Review)")
                    .opacity(0.5)
                    .offset(y: -9)
                
                Spacer()
                VStack {
                    ItemQuantityView()
                    Text("Available Stock")
                        .fontWeight(.medium)
                }
            }
            
            Text("Size")
                .font(.custom("PlayfairDisplay-Bold", size: 20))
            HStack {
                ForEach(0..<3) { size in
                    Text("\(size)")
                        .bold()
                        .padding()
                        .background(Color("Dark"))
                        .clipShape(Circle())
                        .opacity(0.3)
                }
                Spacer()
                VStack {
                    ForEach(0..<3) { color in
                        Color("Dark")
                            .clipShape(Circle())
                    }
                    .frame(width: 50, height: 20)
                }
                .offset(x: -30)
            }
            .offset(y: -9)
            Text("Description")
                .font(.custom("PlayfairDisplay-Bold", size: 20))
            Text("Get a little lift from these Sam Edelman sandals featuring ruched straps and leather lace-up ties, while a braided jute sole makes a fresh statement for summer.")
                .font(.custom("PlayfairDisplay-Regular", size: 12)).opacity(0.6)
                .padding(.top)
            
            
            TotalCostView(cost: 1222)
                .padding(.top, 30)
        }
        .padding()
        .padding(.top)
        .background(Color("Light"))
        .cornerRadius(40)
        
    }
}

struct TotalCostView: View {
    let cost: Int
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
            NavigationLink {
                Payment()
            } label: {
                HStack {
                    Image(systemName: "bag")
                    Text("Add to cart")
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
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "minus")
                    .font(.footnote)
            }
            
            Text("1")
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .font(.footnote)
            }
        }
        .padding(.horizontal, 4)
        .padding(7)
        .foregroundStyle(.black)
        .background(Color("Dark").opacity(0.2))
        .clipShape(Capsule())
    }
}
