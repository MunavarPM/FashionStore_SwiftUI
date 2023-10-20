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
    @State private var isFav = false
    
    
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
                        
                        MostDemandItem(image:UIImage(resource: .shoesClassic), itemName: "Alex Arigato", itemBrand: "Cleam 90's Jacket", rate: 299)
                        
                        /// Categories
                        Text("Categories")
                            .font(.custom("PlayfairDisplay-Bold", size: 26))
                            .fontWeight(.bold)
                            .offset(CGSize(width: 10.0, height: 10.0))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count, id: \.self) { item in
                                    CapsuleButton(isActive: item == selectedIndex, text: categories[item])
                                        .onTapGesture {
                                            selectedIndex = item
                                        }
                                }
                            }
                            .padding(EdgeInsets(top: 4, leading: 10, bottom: 10, trailing: 20))
                        }
                        HStack {
                            Text("Top Dressess")
                                .font(.custom("PlayfairDisplay-Bold", size: 26))
                            Spacer()
                            Button {
                                
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
                                    TopItems(image: .modelJacket, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                    TopItems(image: .modelFT, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                }
                            } else if selectedIndex == 1 {
                                LazyVGrid(columns: gridColumn) {
                                    TopItems(image: .modelSH, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                    TopItems(image: .modelS, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                }
                            } else if selectedIndex == 2 {
                                LazyVGrid(columns: gridColumn) {
                                    TopItems(image: .onBoarding3, fav: $isFav, action: {isFav.toggle()})
                                    TopItems(image: .modelS, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                }
                            } else if selectedIndex == 3 {
                                LazyVGrid(columns: gridColumn) {
                                    TopItems(image: .shoesClassic, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                    TopItems(image: .shoesBoys, fav: $isFav, action: {
                                        withAnimation(.easeInOut) {
                                            isFav.toggle()
                                    }})
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation(.easeInOut) {
                                print("MenuBar pressed")
                            }
                        }label: {
                            
                            MenuBar()
                            
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("show settings")
                        } label: {
                            Image(.modelS)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .background(Color("Dark").opacity(0.2))
                                .clipShape(Circle())
                            
                        }
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}
#Preview {
    HomeView()
}

struct MenuBar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("Dark"))
                .frame(width: 40, height: 40)
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
    var image: UIImage
    var itemName: String
    var itemBrand: String
    var rate: Int
    var body: some View {
        HStack(spacing: 10) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 120, height: 100)
                .cornerRadius(20)
                .offset(x: -15)
            VStack {
                Text(itemName)
                    .font(.custom("PlayfairDisplay-Regular", size: 20))
                Text(itemBrand)
                    .font(.custom("PlayfairDisplay-Regular", size: 15))
                    .foregroundStyle(.gray)
                Text("$ \(rate)")
                    .fontWeight(.bold)
                    .padding(.top, 0.1)
            }
            
            BackButton(forward: true) {
                print("Demand buttin tapped")
            }
            .offset(x: 15)
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
    var image: UIImage
    @Binding var fav: Bool
    let action: () -> Void
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .frame(width: 160, height: 200)
//                    .onTapGesture {
//                        NavigationLink(value: ProductView())
//                    }
                VStack {
                    HStack {
                        Spacer()
                        Button {
                                fav.toggle()
                            print("Button was tapped")
                            action()
                        } label: {
                            Image(systemName: fav ? "heart.fill" : "heart" )
                                .padding(1)
                                .foregroundStyle(.black)
                                .cornerRadius(50)
                                .onTapGesture {
                                    fav.toggle()
                                }
                        }
                        .padding()
                    }
                    Spacer()
                }
                
            }
            
            Text("LP Hut")
                .font(.custom("PlayfairDisplay-Bold", size: 20))
            Text("LP")
                .font(.custom("PlayfairDisplay-Regular", size: 15))
                .foregroundStyle(.gray)
            Text("$ 199")
                .fontWeight(.bold)
        }
        .shadow(color: Color("Dark").opacity(0.2), radius: 10, x: 5, y: 10)
        .padding(.horizontal)
    }
}

struct SearchBar: View {
    @State private var search: String = ""
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
            Button {
                print("sort")
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
//struct ImageSliderView: View {
//    @State private var currentIndex = 0
//    var slides: [String] = ["fni","fn2","fn3","fn4","fn5"]
//    var body: some View {
//        ZStack(alignment: .bottomLeading){
//            ZStack(alignment: .trailing){
//                Image(slides[currentIndex])
//                    .resizable()
//                    .frame(width: .infinity, height: 180)
//                    .scaledToFit()
//                    .cornerRadius(15)
//            }
//            HStack{
//                ForEach(0..<slides.count){index in
//                    Circle()
//                        .fill(self.currentIndex == index ? Color("kPrimary") : Color("kSecondary") )
//                        .frame(width: 10, height: 10)
//                }
//            }
//            .padding()
//        }
//        .padding()
//        .onAppear {
//            Timer .scheduledTimer(withTimeInterval: 5, repeats: true){timer in
//                if self.currentIndex + 1 == self.slides.count{
//                    self.currentIndex = 0
//                }else{
//                    self.currentIndex += 1
//                    }
//                }
//        }
//        }
//    }             
