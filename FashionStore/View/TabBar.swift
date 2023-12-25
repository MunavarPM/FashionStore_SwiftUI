//
//  TabBar.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import SwiftUI

struct TabBar: View {
//    @StateObject var addressVM = AddressViewModel()
    var body: some View {
//        VStack {
//            ForEach(0..<addressVM.addressArray.count, id: \.self) { index in
//                Text(addressVM.addressArray[index].name)
//            }
//        }
        VStack {
            TabView {
                HomeView(isFav: true, product: productList[3])
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                MyCart(product: productList[1], isFav: .constant(false))
//                    .environmentObject(addressVM)
                    .tabItem {
                        Label("Cart", systemImage: "cart.fill")
                    }
                    .tag(1)
                WishlistView(product: productList[0])
                    .tabItem {
                        Label("Whislist", systemImage: "heart.fill")
                    }
                    .tag(2)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(3)
            }
            .accentColor(Color("Dark"))
        }
    }
}

#Preview {
    TabBar()
}

