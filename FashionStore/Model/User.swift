//
//  User.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Codable {
    let id: String?
    let userName:  String?
    let email: String?
    var imagePath: String? = nil
    
//    init(user: User) {
//        self.id = user.id
//        self.userName = user.userName
//        self.email = user.email
//        self.imagePath = user.imagePath
//    }

}


//extension UserD {
//    static let munavar = User(id: NSUUID().uuidString, userName: "munavarD", email: "munavarD@gmail.com")
//}
//    init(user: UserModel) {
//        self.id = user.id
//        self.userName = user.userName
//        self.email = user.email
//        self.imagePath = user.imagePath
//    }
