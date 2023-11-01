//
//  Product.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 17/10/23.
//

import Foundation
import SwiftUI

struct ColorOption: Identifiable {
    var id = UUID()
    var color: Color
    var image: String
}

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
    var suppliers: String
    var discription: String
    var price: Int
    var colors: [ColorOption]
}

var productList = [
    Product(name: "White Stripe Polo Neck T-Shirt"
            , imageName: "ModelFT", suppliers: "AlenSolly", discription: " Polo Neck T-shirt .", price: 1999, colors: [ColorOption(color: Color(.white), image: "ModelFT")]),
    Product(name: "Brown Jacket"
            , imageName: "ModelJacket", suppliers: "Jack & John", discription: "Jacket Long using Winter time.", price: 5999, colors: [ColorOption(color: Color(.brown), image: "ModelJacket")]),
    Product(name: "Shirt Chines Nect"
            , imageName: "modelS", suppliers: "AlenSolly", discription: "Ace weekend dressing Shirt from Allen Solly by Allen Solly.", price: 3999, colors: [ColorOption(color: Color(.systemGreen), image: "modelS")]),
    Product(name: "Men Navy T-Shirt"
            , imageName: "ModelSH", suppliers: "AlenSolly", discription: "Ace weekend dressing in this Navt Stripe Polo Neck T-shirt from Allen Solly by Allen Solly.", price: 1799, colors: [ColorOption(color: Color(.blue), image: "modelSH")])
]
