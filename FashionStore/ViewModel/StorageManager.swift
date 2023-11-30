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
    
    private let storage = Storage.storage().reference()
    
    func saveImage(data: Data) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        
        let path = "\(UUID().uuidString).jpeg"
        let returnMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
        
        guard let returnPath = returnMetaData.path, let returnName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        return (returnPath, returnName)
    }
}
