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
            HomeView(isFav: true, product: productList[3])
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            MyCart(product: productList[1], isFav: .constant(false))
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

#Preview {
    TabBar()
}
//struct text: View {
//    var body: some View {
//        VStack {
//            text2()
//        }
//    }
//}
//struct text2: View {
//    var body: some View {
//        VStack {
//            text3()
//        }
//    }
//}
//struct text3: View {
//    @EnvironmentObject var vm: haloo
//    var body: some View {
//        VStack {
//            Text(vm.h)
//        }
//    }
//}
//
