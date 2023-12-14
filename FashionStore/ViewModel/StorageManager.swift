//
//  StorageManager.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 30/11/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import SwiftUI


final class StorageManager {

    static let shared = StorageManager()
    private init(){ }
    
    private let db = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    func productCollection(imageRef: String) {
        let product = Product(name: "White Stripe Polo Neck T-Shirt"
                           , imageName: [imageRef],
                           suppliers: "AlenSolly", description: "Polo Neck T-shirt .", price: 1999, productCount: 1, colors: ["white", "brown", "gray"], rating: 5, isFavorite: true, profileImagePath: "")

        let data: [String: Any] = [
                "name": product.name,
                "imageName": product.imageName,
                "suppliers": product.suppliers,
                "description": product.description,
                "price": product.price,
                "colors": product.colors,
                "productCount": product.productCount,
                "rating": product.rating,
                "isFavorite": product.isFavorite,
                "profileImagePath": product.profileImagePath ?? ""
            ]
        
        db.collection("productList").document().setData(data)
    }
    func getProductList() async throws -> [Product] {
        let product = Firestore.firestore().collection("productList")
        let snapshot = try await product.getDocuments()
        var productList: [Product] = []
        for doc in snapshot.documents {
            let data = doc.data()
            let id = doc.documentID
            let name = data["name"] as? String ?? ""
            let imageName = data["imageName"] as? [String] ?? []
            let suppliers = data["suppliers"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let price = data["price"] as? Int ?? 0
            let isFavorite = data["isFavorite"] as? Bool ?? false
            let productCount = data["productCount"] as? Int ?? 0
            let rating = data["rating"] as? Float ?? 0.0
            let profileImagePath = data["profileImagePath"] as? String ?? ""
            let colors = data["colors"] as? [String] ?? []
            
            let product = Product(name: name, imageName: imageName, suppliers: suppliers, description: description, price: price, productCount: productCount, colors: colors, rating: rating, profileImagePath: profileImagePath)
            productList.append(product)
        }
        print("\(productList)⚽️")
        return productList
    }
    
//    private var productImageReference: StorageReference {
//        storage.child("product_image")
//    }
    
//    func geProduct() {
//        db.collection("product").getDocuments { (QuerySnapshot?, Error?) in
//            
//        }
//    }
    
    private func productReference(parent: String) -> StorageReference {
        storage.child(parent)
    }
    
//    func saveImage(data: Data, parent: String) async throws -> (path: String?, name: String?) {
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
//        let path = "\(UUID().uuidString).jpeg"
//        
//        do {
//            let returnMetaData = try await productReference(parent: parent).child(path).putDataAsync(data, metadata: meta)
//            
//            guard let returnPath = returnMetaData.path, let returnName = returnMetaData.name else {
//                throw URLError(.badServerResponse)
//            }
//            
//            return (returnPath, returnName)
//        } catch {
//            // Handle the specific error, print or propagate as needed
//            print("Error putting data to Firebase Storage: \(error)")
//            return (nil, nil)
//        }
//    }


    func saveImage(data: Data, parent: String) async throws -> (path: String?, name: String?, url: URL?) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        
        do {
            let storageReference = productReference(parent: parent).child(path)
            _ = try await storageReference.putDataAsync(data, metadata: meta)
            let downloadURL = try await storageReference.downloadURL()
            print("🧑🏽‍💻\(downloadURL)")
            return (path, path, downloadURL)
        } catch {
            // Handle the specific error, print or propagate as needed
            print("Error putting data to Firebase Storage: \(error)")
            return (nil, nil, nil)
        }
    }
    func getData(path: String) async throws -> Data {
        try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    

    
//    func getData(path: String) async throws -> UIImage {
//        let data = try await getData(path: path)
//        
//        guard let image = UIImage(data: data) else {
//            throw URLError(.badServerResponse)
//        }
//        return image
//    }
    
    func getProductData(parent: String, child: String) async throws -> Data {
        try await productReference(parent: parent).data(maxSize: 3 * 1024 * 1024)
    }
}
