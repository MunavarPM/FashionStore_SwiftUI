//
//  AddressViewModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/12/23.
//

import Foundation
import Firebase

class AddressViewModel: ObservableObject {
    
    @Published var userName = "alen"
    @Published var addressArray = [AddressModel]()
    
    let cartRef = Firestore.firestore().collection("address")
    
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        fetchAddress()
    }
    
    func fetchAddress() {
        listenerRegistration = cartRef.document(self.userName).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            guard let addressData = data["address"] as? [[String: Any]] else {
                print("Product data was empty.")
                return
            }
            
            self.addressArray = addressData.map { data in
                if let id = data["id"] as? String,
                   let name = data["name"] as? String,
                   let buildingName = data["buildingName"] as? String,
                   let landmark = data["landmark"] as? String,
                   let street = data["street"] as? String,
                   let city = data["city"] as? String,
                   let state = data["state"] as? String,
                   let zipCode = data["zipCode"] as? String,
                   let country = data["country"] as? String,
                   let phoneNumber1 = data["phoneNumber1"] as? String,
                   let phoneNumber2 = data["phoneNumber2"] as? String {
                   
                    
                    return AddressModel(id: id, name: name, buildingName: buildingName, landmark: landmark, street: street, city: city, state: state, zipCode: zipCode, country: country, phoneNumber1: phoneNumber1, phoneNumber2: phoneNumber2)
                } else {
                    print("nil returning ")
                    return nil // or handle the error case in some other way
                }
            }.compactMap { $0 }
        }
        
        
    }
    
    func stopListening() {
        listenerRegistration?.remove()
    }
    
    func updateAddress(addressModel:AddressModel) {
        let addressId = "6E4BEB90-198C-4924-9098-E7D6BBFC29DA"
        cartRef.document(self.userName).getDocument { (document, error) in
            print(document?.exists as Any)
            if let document = document, document.exists {
                var products = document.data()?["address"] as? [[String: Any]] ?? []
                if let index = products.firstIndex(where: { $0["id"] as? String == addressId }) {
                    /// If the adrress with the given id exists in the array, update its details
                    products[index]["name"] = addressModel.name
                    products[index]["buildingName"] = addressModel.buildingName
                    products[index]["landmark"] = addressModel.landmark
                    products[index]["street"] = addressModel.street
                    products[index]["city"] = addressModel.city
                    products[index]["state"] = addressModel.state
                    products[index]["zipCode"] = addressModel.zipCode
                    products[index]["country"] = addressModel.country
                    products[index]["phoneNumber1"] = addressModel.phoneNumber1
                    products[index]["phoneNumber2"] = addressModel.phoneNumber2
                 
                    self.cartRef.document(self.userName).updateData(["address": products])
                } else {
                    /// If the product with the given name doesn't exist in the array, do nothing
                    print("Product not found")
                    print("no product so calling addProductToCart...")
                    self.addNewAddress(addressModel: addressModel)
                    
                }
            } else {
                /// If the document doesn't exist, do nothing
                print("Document not found")
                self.addNewAddress(addressModel: addressModel)
            }
        }
    }
    
    func addNewAddress(addressModel:AddressModel) {
        cartRef.document(self.userName).getDocument { (document, error) in
            if let document = document, document.exists {
                /// If the document exists, update the array
                var addresses = document.data()?["address"] as? [[String: Any]] ?? []
                /// Create the new address dictionary
                let newAddress = addressModel.adressModelDictionary
                addresses.append(newAddress) // Add the new address to the array
                self.cartRef.document(self.userName).updateData(["address": addresses]) // Update the "address" field in the document with the new array
            } else {
                /// If the document doesn't exist, create it with the new array
                /// Create the new address dictionary
                let newAddress = addressModel.adressModelDictionary
                let addresses = [newAddress] // Create an array with the new product
                self.cartRef.document(self.userName).setData(["address": addresses]) // Set the "address" field in the document with the new array
            }
        }
    }
    
    func deleteProductFromCart(addressId: String) {
        cartRef.document(self.userName).getDocument { (document, error) in
            if let document = document, document.exists {
                /// If the document exists, update the array
                var addresses = document.data()?["address"] as? [[String: Any]] ?? []
                addresses.removeAll { $0["id"] as? String == addressId } // Remove the address with matching name
                self.cartRef.document(self.userName).updateData(["address": addresses]) // Update the "address" field in the document with the modified array
            }
        }
    }
}
