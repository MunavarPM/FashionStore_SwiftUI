//
//  AddressModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/12/23.
//

import Foundation

struct AddressModel {
    let id:String
    let name:String
    let buildingName:String?
    let landmark:String
    var street: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
    var phoneNumber1:String
    var phoneNumber2:String
    
    var adressModelDictionary:[String:Any]{
        return ["id":id,"name":name,"buildingName":buildingName ?? "nil" ,"landmark":landmark,"street":street,"city":city,"state":state,"zipCode":zipCode,"country":country,"phoneNumber1":phoneNumber1,"phoneNumber2":phoneNumber2]
    }
    
    init(){
        self.id = ""
        self.name = ""
        self.buildingName = ""
        self.landmark = ""
        self.street = ""
        self.city = ""
        self.state = ""
        self.zipCode = ""
        self.country = ""
        self.phoneNumber2 = ""
        self.phoneNumber1 = ""
    }
    
    init(id:String,name:String,buildingName:String,landmark:String,street:String,city:String,state:String,zipCode:String,country:String,phoneNumber1:String,phoneNumber2:String){
        self.id = id
        self.name = name
        self.buildingName = buildingName
        self.landmark = landmark
        self.street = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
        self.phoneNumber2 = phoneNumber2
        self.phoneNumber1 = phoneNumber1
    }
}
