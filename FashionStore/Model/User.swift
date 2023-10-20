//
//  User.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let userName:  String
    let email: String
}
extension User {
    static let munavar = User(id: NSUUID().uuidString, userName: "munavar", email: "munavar@gmail.com")
}
