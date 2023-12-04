//
//  ProductManager.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 01/11/23.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseFirestore

class ProductManagerViewModel: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    @Published private(set) var wishlistProducts: [WishlistProduct] = [] // New array for wishlist
    @Published private(set) var wishlistTotal: Int = 0
    @Published private(set) var cartProducts: [CartProduct] = []
    @Published private(set) var cartTotal: Int = 0
    @Published var selectedFilter: FilterOption? = nil
    
    
    
    
    func addtoCart(product: Product) {
        if let existingProduct = cartProducts.first(where: { $0.product == product }) {
            existingProduct.productCount += 1
        } else {
            
            let cartProduct = CartProduct(product: product)
            cartProducts.append(cartProduct)
        }
        cartTotal += product.price
        print("\(products.count)😎Cart")
    }
    
    func removeFromCart(product: Product) {
        if let existingProductIndex = cartProducts.firstIndex(where: { $0.product == product }) {
            cartProducts.remove(at: existingProductIndex)
        }
        cartTotal -= product.price
    }
    
    func minusProductCart(product: Product){
        if let existingProductIndex = cartProducts.firstIndex(where: { $0.product == product }) {
            
            
            if cartProducts[existingProductIndex].productCount == 1 {
                removeFromCart(product: product)
                
            }else{
                cartProducts[existingProductIndex].productCount -= 1
                cartTotal -= product.price
            }
        }
    }
    
    func getProductCount(product: Product) -> Int {
        if let existingProductIndex = cartProducts.firstIndex(where: { $0.product == product }) {
            return cartProducts[existingProductIndex].productCount
        }
        return 0
    }
    
    func increaseProductCount(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].productCount += 1
        }
    }
    
    func decreaseProductCount(product: Product) {
        var filteredProduct = products.filter({ item in
            product.id == item.id
        })
        if filteredProduct.count > 1 {
            filteredProduct[0].productCount -= 1
        }
    }
    
    func addToWishlist(product: Product) {
        if let exist = wishlistProducts.first(where: {
            $0.product == product
        }) {
            exist.productCount += 1
        } else {
            let wish = WishlistProduct(product: product)
            wishlistProducts.append(wish)
            wishlistTotal += product.price
            print("\(wishlistProducts.count) ❤️Wishlist")
        }
    }
    
    func removeFromWishlist(product: Product) {
        if let index = wishlistProducts.firstIndex(where: { $0.product == product }) {
            wishlistProducts.remove(at: index)
        }
        wishlistTotal -= product.price
    }
    
    func toggleFavorite(_ product: Product) {
            if let index = products.firstIndex(where: { $0.id == product.id }) {
                products[index].isFavorite.toggle()  // Toggle the favorite status
                if products[index].isFavorite {
                    addToWishlist(product: product)
                } else {
                    removeFromWishlist(product: product)
                }
            }
        }
    func saveProductImage(item: PhotosPickerItem, parent: String, child: String) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await StorageManager.shared.saveImage(data: data, parent: parent, child: child)
            print("ProductImageSaved")
            print("\(path)🛣️")
            print("\(name)🙋🏽‍♂️")
//            try await StorageManager.shared.
            
        }
    }
    
//    func filterSelectedOption(option: FilterOption) async throws {
//        switch option {
//        case .noFilter:
//            self.products = try await productList
//        case .priceHigh:
//            self.products = try await productList.
//        }
//    }
//    func getAllroductSortedByPrice(desending: Bool) async throws -> [Product]{
//        
//    }
}

class CartProduct: Identifiable {
    var product: Product
    var productCount: Int
    init(product: Product) {
        self.product = product
        self.productCount = 1
    }
}
class WishlistProduct: Identifiable {
    var product: Product
    var productCount: Int
    init(product: Product) {
        self.product = product
        self.productCount = 1
    }
}
enum FilterOption: String, CaseIterable {
    case noFilter
    case priceHigh
    case priceLow
}
