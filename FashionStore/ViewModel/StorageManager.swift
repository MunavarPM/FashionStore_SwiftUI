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
import FirebaseAuth


final class StorageManager {

    static let shared = StorageManager()
    private init(){ }
    
    private let db = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    private func productReference(parent: String) -> StorageReference {
        storage.child(parent)
    }
    
    private let userCollection = Firestore.firestore().collection("user")
    
    private func userDocument(userID: String) -> DocumentReference { /// Fetching user for product detail's
        userCollection.document(userID)
    }
    
    func updateFavouriteProduct(userID: User) async throws {
        if let id = userID.id {
            try userDocument(userID: id).setData(from: userID, merge: true)
        }
    }
    
    func UploadProfileImage(data: Data) {
        guard let user = Auth.auth().currentUser else { return }
        let storagaRef = Storage.storage().reference()
        let path = "profileImage/\(UUID().uuidString).jpg"
        let imageData = storagaRef.child(path)
        let uploadData = imageData.putData(data, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                self.userCollection.document(user.uid).setData(["profileImage" : path])
                print("Profile Image Uploaded")
            } else {
                print("Error in uploading profile image")
            }
        }
    }
    
    func productCollection(imageRef: String) {
        let product = Product(id: UUID().uuidString, name: "White Stripe Polo Neck T-Shirt"
                           , imageName: [imageRef],
                           suppliers: "AlenSolly", description: "Polo Neck T-shirt .", price: 1999, productCount: 1, colors: ["white", "brown", "gray"], rating: 5, isFavorite: true, profileImagePath: "")

        let data: [String: Any] = [
                "id": product.id ?? "",
                "name": product.name,
                "imageName": product.imageName,
                "suppliers": product.suppliers,
                "description": product.description,
                "price": product.price,
                "colors": product.colors,
                "productCount": product.productCount,
                "rating": product.rating,
                "isFavorite": product.isFavorite,
                "profileImagePath": product.profileImagePath 
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
            
            let product = Product(id: id, name: name, imageName: imageName, suppliers: suppliers, description: description, price: price, productCount: productCount, colors: colors, rating: rating, isFavorite: isFavorite, profileImagePath: profileImagePath)
            productList.append(product)
        }
        return productList
    }
    
    
    func getProductList(forDocumentID documentID: String) async throws -> [Product] {
        
        let product = Firestore.firestore().collection("productList").document(documentID)
        let snapshot = try await product.getDocument()

        var productList: [Product] = []

        if snapshot.exists {
            let data = snapshot.data()!
            let id = snapshot.documentID
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

            let product = Product(id: id, name: name, imageName: imageName, suppliers: suppliers, description: description, price: price, productCount: productCount, colors: colors, rating: rating, isFavorite: isFavorite, profileImagePath: profileImagePath)
            
            productList.append(product)
        } else {
            print("Document with ID \(documentID) does not exist.")
        }

        return productList
    }

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
    
    
    func getProductData(parent: String, child: String) async throws -> Data {
        try await productReference(parent: parent).data(maxSize: 3 * 1024 * 1024)
    }
}
