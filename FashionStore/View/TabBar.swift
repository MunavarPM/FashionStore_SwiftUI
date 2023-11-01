//
//  TabBar.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            MyCart(product: productList[1])
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(1)
            WishlistView()
                .tabItem {
                    Label("Whislist", systemImage: "heart.fill")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Label("Settings", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(Color("Dark"))
    }
}

#Preview {
    TabBar()
}
