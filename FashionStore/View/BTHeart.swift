//
//  BTHeart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 15/10/23.
//

import SwiftUI

struct BTHeart: View {
    @EnvironmentObject var productManagerVM: ProductManagerViewModel
    @Binding var isFav: Bool
    var product: Product
    let action: () -> ()
    var body: some View {
        HStack {
            Spacer()
            Button {
                if product.isFavorite {
                  productManagerVM.addToWishlist(product: product)
                } else {
                    productManagerVM.removeFromWishlist(product: product)
                }
                isFav.toggle()
            } label: {
                Image(systemName: isFav ? "heart.fill" : "heart" )
                    .font(.title3)
                    .foregroundStyle(.black)
                    .cornerRadius(50)
                    .padding(7)
                    .background(Circle())
                    .foregroundStyle(.white)
            }
        }
    }
}
#Preview {
    BTHeart(isFav: .constant(false), product: productList[1], action: {})
        .environmentObject(ProductManagerViewModel())
        .preferredColorScheme(.dark)
}





