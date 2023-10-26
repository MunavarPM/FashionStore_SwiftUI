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
                    .fontWeight(.bold)
                    .foregroundStyle(Color("Dark"))
                    .padding(10)
                    .background(Color("Light"))
                    .clipShape(Circle())
                if numberOfProduct > 0 {
                    Text("\(numberOfProduct)")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .frame(width: 15, height: 15)
                        .background(.black)
                        .cornerRadius(50)
                        .offset(x: 9, y: -7)
                }
            }
        }
    }
}

#Preview {
    CartButton(numberOfProduct: 2, action: {})
}
