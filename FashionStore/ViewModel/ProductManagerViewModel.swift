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

@MainActor
class ProductManagerViewModel: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    @Published private(set) var wishlistProducts: [WishlistProduct] = [] // New array for wishlist
    @Published private(set) var wishlistTotal: Int = 0
    @Published private(set) var cartProducts: [CartProduct] = []
    @Published private(set) var cartTotal: Int = 0
    @Published var orderList: [CartProduct] = []
    @Published var selectedFilter: FilterOption? = nil
    @Published var productList: [Product] = []
    @Published var jacketList: [Product] = []
    @Published var shirtList: [Product] = []
    @Published var tshirtList: [Product] = []
    @Published var shoesList: [Product] = []
   
    
    
    func updateisFavorite(user: User) {
        
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
    
        
    //MARK: Extra call for SwifFullthinking
    func loadCurrentUser() async throws {
        do {
            let user = try AuthViewModel().getAuthUser()
            print("\(user)😎")
        } catch {
            print("error")
        }
    }
 
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
    
    func removeAllFromCart() {
        orderList.append(contentsOf: cartProducts)
        print("\(orderList.count)📋📋📋")
        cartProducts.removeAll()
        cartTotal = 0
    }
    
    func minusProductCart(product: Product){
        if let existingProductIndex = cartProducts.firstIndex(where: { $0.product == product }) {
            
            
            if cartProducts[existingProductIndex].productCount == 1 {
                removeFromCart(product: product)
                
            } else {
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
    
    
    func saveProductImage(item: PhotosPickerItem, parent: String) {
        Task {
            guard let data = try? await item.loadTransferable(type: Data.self) else { return }
            
            do {
                let (path, name, url) = try await StorageManager.shared.saveImage(data: data, parent: parent)
                
                if let path = path, let name = name, let url = url {
                    print("Product Image Saved")
                    print("Path: \(path)")
                    print("Name: \(name)")
                    print("URL: \(url)")
                } else {
                    print("Failed to get image details")
                }
            } catch {
                // Handle the specific error, print or propagate as needed
                print("Error saving product image: \(error)")
            }
        }
    }

    
    func fetData(){
        Task {
            do {
                self.productList = try await StorageManager.shared.getProductList()
                print("Data fetched successfully")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    
    func fetchJacketData(){
        let id = "4QM1bM5XTtBAP1bkQvrK"
        Task {
            do {
                self.jacketList = try await StorageManager.shared.getProductList(forDocumentID: id)
                print("fetchJacketData fetched successfully")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchShirtData() {
        let id = "9dYggpK29qD3C7IuNx8s"
        Task {
            do {
                self.shirtList = try await StorageManager.shared.getProductList(forDocumentID: id)
                print("fetchShirtData successfully")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchTshirtData() {
        let id = "3SBlq8zm1jNfibzGEo5m"
        Task {
            do {
                self.tshirtList = try await StorageManager.shared.getProductList(forDocumentID: id)
                print("fetchTshirtData successfully")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchShoesData() {
        let id = "GjvxIo5QOilAMDoMx23P"
        Task {
            do {
                self.shoesList = try await StorageManager.shared.getProductList(forDocumentID: id)
                print("fetchShoesData successfully")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    
    
    
    
    
    
//    func getProductList() async throws -> [Product] {
//        let product = Firestore.firestore().collection("productList")
//        
//    }
    
//    func saveProductImage(item: PhotosPickerItem, parent: String) {
//            Task {
//                do {
//                    guard let data = try await item.loadTransferable(type: Data.self) else { return }
//                    let (path, name) = try await StorageManager.shared.saveImage(data: data, parent: parent)
//                    print("ProductImageSaved")
//                    print("\(path ?? "")🛣️")
//                    print("\(name ?? "")🙋🏽‍♂️")
//
//                    // Assuming StorageManager.shared.saveImage returns the path to the saved image
//                    if let imagePath = path {
//                        // Load the saved image using the path
//                        if let uiImage = UIImage(contentsOfFile: imagePath) {
//                            // Update the @Published property
//                            DispatchQueue.main.async {
//                                self.retrievedImage.append(uiImage)
//                                print("\(self.retrievedImage.count)➕")
//                            }
//                        }
//                    }
//                } catch {
//                    print("Error saving or loading image: \(error)")
//                }
//            }
//        }
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
