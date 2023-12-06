//
//  StorageManager.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 30/11/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore


final class StorageManager {

    static let shared = StorageManager()
    private init(){ }
    
    private let db = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
//    private var productImageReference: StorageReference {
//        storage.child("product_image")
//    }
    
//    func geProduct() {
//        db.collection("product").getDocuments { (QuerySnapshot?, Error?) in
//            
//        }
//    }
    
    private func productReference(parent: String, child: String) -> StorageReference {
        storage.child(parent).child(child)
    }
    
    func saveImage(data: Data, parent: String, child: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        let returnMetaData = try await productReference(parent: parent, child: child).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnPath = returnMetaData.path, let returnName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        return (returnPath, returnName)
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
        try await productReference(parent: parent, child: child).data(maxSize: 3 * 1024 * 1024)
    }
}
