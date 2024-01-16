//
//  CartButton.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 16/10/23.
//

import SwiftUI

struct CartButton: View {
    var numberOfProduct: Int
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(systemName: "bag")
                    .font(.body)
                    .scaleEffect(0.85)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("AccentColor2"))
                    .padding(7)
                    .background(Color("AccentColor"))
                    .clipShape(Circle())
                if numberOfProduct > 0 {
                    Text("\(numberOfProduct)")
                        .font(.caption2)
                        .foregroundStyle(Color("AccentColor"))
                        .frame(width: 15, height: 15)
                        .background(Color("AccentColor2"))
                        .cornerRadius(50)
                        .offset(x: 9, y: -7)
                }
            }
        }
    }
}

#Preview {
    CartButton(numberOfProduct: 1, action: {})
}
