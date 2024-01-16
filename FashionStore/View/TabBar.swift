//
//  TabBar.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import SwiftUI

struct TabBar: View {
    
    @State var selectedTab = 0
    @AppStorage ("TabSelection1") var TabSelection = -1
    @ObservedObject var viewModel = LoginRegisterViewModel()

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
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
                ProfileView(LogicVM: viewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(3)
            }
            .accentColor(Color("AccentColor2"))
        }
        .onChange(of: TabSelection) { _ in
            selectedTab = TabSelection
            print("TabSelection", selectedTab, TabSelection)
        }
        .onAppear {
            TabSelection = -1
            print("☀️TabSelectionOnAppeaer", selectedTab, TabSelection)
        }
    }
}

//#Preview {
//    TabBar()
//}

