//
//  HomeView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI


struct HomeView: View {
    private let categories = ["Dresses", "Jackets", "Jeans", "Shoese"]
    @State private var selectedIndex: Int = 0
    @State var isFav: Bool
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    
    var product: Product
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        TagLineView()
                            .padding(.leading, 2)
                        
                        SearchBar()
                        
                        MostDemandItem(itemName: "Alex Arigato", itemBrand: "Cleam 90's Jacket", rate: 299)
                        
                        Text("Categories")
                            .font(.custom("PlayfairDisplay-Bold", size: 26))
                            .fontWeight(.bold)
                            .offset(CGSize(width: 10.0, height: 10.0))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count, id: \.self) { item in
                                    CapsuleButton(isActive: item == selectedIndex, text: categories[item])
                                        .onTapGesture {
                                            withAnimation(.easeIn(duration: 0.4)){
                                                selectedIndex = item
                                            }
                                        }
                                }
                            }
                            .padding(EdgeInsets(top: 4, leading: 10, bottom: 10, trailing: 20))
                        }
                        HStack {
                            Text("Top Dressess")
                                .font(.custom("PlayfairDisplay-Bold", size: 26))
                            Spacer()
                            NavigationLink {
                                ViewAll()
                            } label: {
                                Text("View All")
                                    .font(.custom("PlayfairDisplay-Regular", size: 16))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.vertical) {
                            let gridColumn: [GridItem] = [GridItem(), GridItem()]
                            if selectedIndex == 0 {
                                LazyVGrid(columns: gridColumn) {
                                    ForEach(productManagerVM.tshirtList.prefix(2), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item) {
                                                if product.isFavorite {
                                                    productManagerVM.addToWishlist(product: product)
                                                } else {
                                                    productManagerVM.removeFromWishlist(product: product)
                                                }
                                            }
                                        }
                                    }
                                    .onAppear {
                                        productManagerVM.fetchTshirtData()
                                    }
                                    ForEach(productManagerVM.shirtList.prefix(5), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item,  action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                    productManagerVM.addToWishlist(product: item)
                                                }
                                            })
                                        }
                                    }
                                }
                                .onAppear {
                                    productManagerVM.fetchShirtData()
                                }
                            } else if selectedIndex == 1 {
                                LazyVGrid(columns: gridColumn) {
                                    ForEach(productManagerVM.jacketList.prefix(3), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                    productManagerVM.addToWishlist(product: item)
                                                }
                                            })
                                        }
                                    }
                                    ForEach(productManagerVM.jacketList.prefix(0), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                    productManagerVM.addToWishlist(product: item)
                                                }
                                            })
                                        }
                                    }
                                }
                                .onAppear {
                                    productManagerVM.fetchJacketData()
                                }
                            } else if selectedIndex == 2 {
                                LazyVGrid(columns: gridColumn) {
                                    ForEach(productManagerVM.shirtList.prefix(4), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                }
                                            })
                                        }
                                    }
                                    ForEach(productManagerVM.shirtList.prefix(1), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                }
                                            })
                                        }
                                    }
                                }
                                .onAppear {
                                    productManagerVM.fetchShirtData()
                                }
                            } else if selectedIndex == 3 {
                                LazyVGrid(columns: gridColumn) {
                                    ForEach(productManagerVM.shoesList.prefix(5), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                }
                                            })
                                        }
                                    }
                                    ForEach(productManagerVM.shoesList.prefix(0), id: \.id){ item in
                                        NavigationLink(destination: ProductView(isFav: $isFav, product: item).environmentObject(productManagerVM)) {
                                            TopItems(product: item, action: {
                                                withAnimation(.easeOut) {
                                                    isFav.toggle()
                                                }
                                            })
                                        }
                                    }
                                }
                                .onAppear {
                                    productManagerVM.fetchShoesData()
                                }
                            }
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {} label: {
                        Image(.modelS)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .background(Color("Dark").opacity(0.2))
                            .clipShape(Circle())
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            print("MenuBar pressed")
                        }
                    }label: {
                        MenuBar()
                    }
                }
            }
            .navigationBarHidden(false)
        }
    }
}

#Preview {
    HomeView(isFav: true, product: productList[3])
        .environmentObject(ProductManagerViewModel())
}

struct MenuBar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("Dark"))
                .frame(width: 38, height: 38)
                .overlay {
                    VStack(alignment: .center, spacing: 4.5) {
                        Rectangle()
                            .frame(width: 12, height: 3)
                            .offset(x: 5)
                        Rectangle()
                            .frame(width: 20, height: 3)
                        Rectangle()
                            .frame(width: 12, height: 3)
                            .offset(x: -5)
                    }
                    .foregroundStyle(Color("Light"))
                }
        }
    }
}

struct TagLineView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 20)
            Text("Welcome,")
                .font(.custom("PlayfairDisplay-Bold", size: 28))
                .foregroundStyle(Color("Dark"))
            Text("Our Fashion App")
                .font(.custom("PlayfairDisplay-Regular", size: 25))
                .foregroundStyle(Color("Dark"))
        }
        .padding()
    }
}

struct CapsuleButton: View {
    let isActive: Bool
    let text: String
    var body: some View {
        HStack {
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(isActive ? "Light": "Dark"))
                    .frame(width: 85, height: 18)
                    .padding(.vertical, 10)
                
            }
            .background(Color(isActive ? "Dark" : "Light"))
            .clipShape(Capsule())
        }
    }
}

struct MostDemandItem: View {
    @State private var currentIndex = 0
    var itemName: String
    var itemBrand: String
    var rate: Int
    var slides: [Product] = [productList[3], productList[1], productList[2]]
    var body: some View {
        ForEach(slides[currentIndex].imageName, id: \.self){ slide in
            HStack(spacing: 10) {
                Image(slide)
                    .resizable()
                    .frame(width: 110, height: 100)
                    .cornerRadius(20)
                    .offset(x: -18)
                VStack {
                    Text(slides[currentIndex].name)
                        .font(.custom("PlayfairDisplay-Regular", size: 20))
                    Text(itemBrand)
                        .font(.custom("PlayfairDisplay-Regular", size: 15))
                        .foregroundStyle(.gray)
                    Text("$ \(slides[currentIndex].price)")
                        .fontWeight(.bold)
                        .padding(.top, 0.1)
                }
                
                NavigationLink {
                    
                } label: {
                    BackButton(forward: true) {}
                }
                .offset(x: 15)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.4))
                .background(Color("Light").opacity(0.9).cornerRadius(20))
                .shadow(color: Color("Dark").opacity(0.2), radius: 12, x: 0, y: 5)
                .frame(width: 350, height: 120)
        }
        .offset(x: 40, y: 9)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                if self.currentIndex + 1 == self.slides.count {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
            }
        }
    }
}

struct BackButton: View {
    let forward: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: forward ? "chevron.forward" : "chevron.backward")
                .foregroundColor(.white)
                .padding(.all, 6)
                .background(Color.black)
                .cornerRadius(8.0)
        }
    }
}

struct TopItems: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    var product: Product
    let action: () -> Void

    var body: some View {
        VStack {
            ForEach(product.imageName, id: \.self) { img in
                ZStack {
                    if let url = URL(string: img) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .frame(width: 160, height: 200)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                    VStack {
                        Button(action: {
                            action()
                        }, label: {
                            Image(systemName: product.isFavorite ? "heart.fill" : "heart" )
                                .font(.title3)
                                .foregroundStyle(.black)
                                .cornerRadius(50)
                                .padding(7)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .onTapGesture {
                            productManagerVM.addToWishlist(product: product)
                        }
                    }
                    .padding(10)
                }

                VStack {
                    Text(product.name) // Display the product name
                        .font(.custom("PlayfairDisplay-Bold", size: 18))
                    Text(product.suppliers)
                        .font(.custom("PlayfairDisplay-Regular", size: 15))
                        .foregroundStyle(.gray)
                    Text("$ \(product.price)")
                        .fontWeight(.bold)
                }
                .padding(10)
            }
        }
        .shadow(color: Color("Dark").opacity(0.2), radius: 10, x: 5, y: 10)
        .padding(.horizontal)
    }
}


struct SearchBar: View {
    @State private var search: String = ""
    @EnvironmentObject var productManagerViewModel: ProductManagerViewModel
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .padding()
                TextField("Search...", text: $search)
                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                    .autocapitalization(.none)
                    .frame(height: 52)
            }
            .frame(height: 52)
            .background(Color("Dark").cornerRadius(32)
                .opacity(0.1))
            
            .overlay {
                Capsule()
                    .stroke(Color.white.opacity(1.0))
                    .blendMode(.overlay)
            }
            Menu {
                ForEach(FilterOption.allCases, id: \.self) { Identifiable in
                    Button(Identifiable.rawValue) {
                        
                    }
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color("Dark"))
                        .cornerRadius(10)
                        .frame(width: 45, height: 45)
                        .overlay {
                            VStack(alignment: .center, spacing: 7) {
                                HStack(spacing: -0.6) {
                                    Circle()
                                        .frame(width: 7, height: 7)
                                        .offset(x: 0)
                                    Rectangle()
                                        .frame(width: 13, height: 3)
                                        .offset(x: 5)
                                        .opacity(0.5)
                                }
                                HStack(spacing: -0.6) {
                                    Rectangle()
                                        .frame(width: 13, height: 3)
                                        .offset(x: 0)
                                        .opacity(0.5)
                                    Circle()
                                        .frame(width: 7, height: 7)
                                        .offset(x: 5)
                                }
                            }
                            .foregroundStyle(Color("Light"))
                        }
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

