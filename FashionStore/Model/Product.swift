//
//  Product.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 17/10/23.
//

import Foundation
import SwiftUI


struct Product: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var suppliers: String
    var discription: String
    var price: Int
    var productCount: Int
    var colors: [ColorOption]
    var rating: Float
    var isFavorite: Bool
    
    mutating func toggleFavorite() {
        isFavorite.toggle()
    }
}

extension Product: Equatable {
    // Product sınıfının diğer özellikleri ve fonksiyonları

    static func ==(lhs: Product, rhs: Product) -> Bool {
        // Burada Product sınıfının eşitlik kontrolü nasıl yapılacaksa onu belirtin
        // Örneğin, ürünlerin bir benzersiz kimliklerine (ID) sahip olduğunu varsayalım
        return lhs.id == rhs.id
    }
}

struct ColorOption: Identifiable {
    var id = UUID()
    var color: Color
    var color2: Color
    var color3: Color
}

var productList = [
    Product(name: "White Stripe Polo Neck T-Shirt"
            , imageName: "ModelJacket", suppliers: "AlenSolly", discription: " Polo Neck T-shirt .", price: 1999, productCount: 1, colors: [ColorOption(color: Color(.white), color2: Color(.brown), color3: Color(.gray))], rating: 5, isFavorite: true),
    Product(name: "Brown Jacket"
            , imageName: "ModelS", suppliers: "Jack & John", discription: "Jacket Long using Winter time.", price: 5999, productCount: 1, colors: [ColorOption(color: Color(.white), color2: Color(.brown), color3: Color(.gray))], rating: 2, isFavorite: false),
    Product(name: "RoadAxe"
            , imageName: "ShoesBoys", suppliers: "Kalvin", discription: "Main Design for Street look, And road shoes.", price: 3999, productCount: 1, colors: [ColorOption(color: Color(.black), color2: Color(.brown), color3: Color(.gray))], rating: 4, isFavorite: false),
    Product(name: "Men Classic"
            , imageName: "ShoesClassic", suppliers: "Bricks", discription: "Mainly Design for office and casual use.", price: 1799, productCount: 1, colors: [ColorOption(color: Color(.yellow), color2: Color(.green), color3: Color(.red))], rating: 3, isFavorite: false)
]
