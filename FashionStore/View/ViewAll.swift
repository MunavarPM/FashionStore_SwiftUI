//
//  ViewAll.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 04/11/23.
//

import SwiftUI

struct ViewAll: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @State private var isFav = false
    var column = [GridItem(.adaptive(minimum:160), spacing: 20)]

    var body: some View {
        NavigationStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: column) {
                            ForEach(productList, id: \.id) { item in
                                NavigationLink {
                                    TopItems(product: item, fav: isFav, action: {})
                                } label: {
                                    TopItems(product: item, fav: isFav, action: {})
                                }
                            }
                        }
                    }
            
        }
        .navigationTitle("View All").navigationBarTitleDisplayMode(.automatic)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                DismissView()
            }
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ViewAll()
        .environmentObject(ProductManagerViewModel())
}

struct ViewAllTitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("View All")
                .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                .padding([.leading, .top], 20)
        }
    }
}
