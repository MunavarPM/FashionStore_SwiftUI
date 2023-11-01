//
//  ProductManager.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 01/11/23.
//

import Foundation


class ProductManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    
    func addtoCart(product: Product) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Product) {
        products = products.filter { $0.id != product.id }
        total -= product.price
    }
}
