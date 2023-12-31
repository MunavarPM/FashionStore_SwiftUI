//
//  Product.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 17/10/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift



struct Product: Identifiable {
    let id: String?
    let name: String
    let imageName: [String]
    let suppliers: String
    let description: String
    let price: Int
    var productCount: Int
    let colors: [String]
    let rating: Float
    var isFavorite: Bool
    let profileImagePath: String
     
    
    init(id: String?, name: String, imageName: [String], suppliers: String, description: String, price: Int, productCount: Int, colors: [String], rating: Float, isFavorite: Bool, profileImagePath: String?) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.suppliers = suppliers
        self.description = description
        self.price = price
        self.productCount = productCount
        self.colors = colors
        self.rating = rating
        self.isFavorite = false
        self.profileImagePath = profileImagePath ?? ""
    }
    
    
    mutating func toggleFavorite() {
        let currentValue = isFavorite
        isFavorite = !currentValue
    }
//        init(user: User) {
//            self.isFavorite = false
//        }
    //    init(isFavorite: Bool? = nil) {
    //        self.isFavorite = isFavorite
    //    }
    //    func toggleFav() -> Product {
    //        let currentValue = isFavorite ?? false
    //        return Product(isFavorite: !currentValue)
    //    }
}

struct ColorOption: Identifiable {
    var id = UUID()
    var color: String
    var color2: String
    var color3: String
}

enum CodingKeys: String, CodingKey {
    case jacket = "jacket"
    case shirt = "shirt"
    case shoes = "shoes"
    case tshirt = "tshirt"
}

enum CustomColor: String {
    case white = "white"
    case brown = "brown"
    case gray = "gray"
    
    func toUIColor() -> UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .brown:
            return UIColor.brown
        case .gray:
            return UIColor.gray
        }
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

var productList = [
    Product(id: UUID().uuidString, name: "White Stripe Polo Neck T-Shirt"
            , imageName: ["ModelJacket"], suppliers: "AlenSolly", description: "Polo Neck T-shirt.", price: 1999, productCount: 1, colors: ["white", "brown", "gray"], rating: 5, isFavorite: true, profileImagePath: ""),
    Product(id: UUID().uuidString, name: "Brown Jacket"
            , imageName: ["ModelS"], suppliers: "Jack & John", description: "Jacket Long using Winter time.", price: 5999, productCount: 1, colors: ["white", "brown", "gray"], rating: 2, isFavorite: false, profileImagePath: ""),
    Product(id: UUID().uuidString, name: "RoadAxe"
            , imageName: ["ShoesBoys"], suppliers: "Kalvin", description: "Main Design for Street look, And road shoes.", price: 3999, productCount: 1, colors: ["white", "brown", "gray"], rating: 4, isFavorite: false, profileImagePath: ""),
    Product(id: UUID().uuidString, name: "Men Classic"
            , imageName: ["ShoesClassic"], suppliers: "Bricks", description: "Mainly Design for office and casual use.", price: 1799, productCount: 1, colors: ["white", "brown", "gray"], rating: 3, isFavorite: false, profileImagePath: "")
]
