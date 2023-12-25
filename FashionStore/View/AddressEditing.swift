//
//  AddressEditing.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/12/23.
//

import SwiftUI

struct AddressEditing: View {
    
    @ObservedObject var addressViewModel: AddressViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var nameTxt = ""
    @State var buildingNameTxt = ""
    @State var landmarkTxt = ""
    @State var streetTxt = ""
    @State var cityTxt = ""
    @State var stateTxt = ""
    @State var zipTxt = ""
    @State var countryTxt = ""
    @State var phoneNumber1Txt = ""
    @State var phoneNumber2Txt = ""
    
    @Binding var enableEditAddress: Bool
    @Binding var showAddAddressView: Bool
    @Binding var tappedAddress: AddressModel
    
    var body: some View {
//        NavigationStack {
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Group {
                            Text("Name :")
                            Text("Building :")
                            Text("landmark :")
                            Text("street :")
                            Text("city :")
                            Text("state :")
                            Text("zipcode :")
                            Text("country :")
                            Text("phone no.1 :")
                            Text("phone no.2 :")
                        }
                        .font(.custom("PlayfairDisplay-Bold", size: 18))
                    }
                    .padding()
                    VStack{
                        Group {
                            TextField("Name", text: $nameTxt)
                            TextField("Building Name", text: $buildingNameTxt)
                            TextField("Landmark", text: $landmarkTxt)
                            TextField("Street", text: $streetTxt)
                            TextField("City", text: $cityTxt)
                            TextField("State", text: $stateTxt)
                            TextField("Zipcode", text: $zipTxt)
                            TextField("Country", text: $countryTxt)
                            TextField("PhoneNumber 1", text: $phoneNumber1Txt)
                            TextField("Phone Number 2", text: $phoneNumber2Txt)
                        }
                        .font(.custom("GreatVibes-Regular", size: 19))
                    }
                }
                .padding(.bottom)
                HStack {
                    Text("Save address")
                        .font(.custom("PlayfairDisplay-Bold", size: 20))
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color("Dark"))
                .cornerRadius(20)
                .foregroundColor(Color("Light"))
                
                .shadow(color:.black,radius: 3)
                .onTapGesture {
                    
                    //MARK: means adding new address
                    
                    if enableEditAddress == false {
                        let id = UUID().uuidString
                        let newAddress = AddressModel(id: id,name: nameTxt, buildingName: buildingNameTxt, landmark: landmarkTxt, street: streetTxt, city: cityTxt, state: stateTxt, zipCode: zipTxt, country: countryTxt, phoneNumber1: phoneNumber1Txt, phoneNumber2: phoneNumber2Txt)
                        addressViewModel.updateAddress(addressModel: newAddress)
                    } else {
                        
                        //MARK: means editing address so no need to use another id use same id.
                        
                        let newAddress = AddressModel(id: tappedAddress.id,name: nameTxt, buildingName: buildingNameTxt, landmark: landmarkTxt, street: streetTxt, city: cityTxt, state: stateTxt, zipCode: zipTxt, country: countryTxt, phoneNumber1: phoneNumber1Txt, phoneNumber2: phoneNumber2Txt)
                        addressViewModel.updateAddress(addressModel: newAddress)
                    }
                    showAddAddressView = false
                }
                
                if enableEditAddress {
                    HStack{
                        Text("Update address")
                            .font(.custom("PlayfairDisplay-Bold", size: 20))
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("Dark"))
                    .cornerRadius(20)
                    .foregroundColor(Color("Light"))
                    
                    .shadow(color:.black,radius: 3)
                    .onTapGesture {
                        addressViewModel.deleteProductFromCart(addressId: tappedAddress.id)
                        showAddAddressView = false
                    }
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding()
            .background(Color("Light"))
            .onAppear {
                if enableEditAddress {
                    nameTxt = tappedAddress.name
                    buildingNameTxt = tappedAddress.buildingName ?? ""
                    landmarkTxt = tappedAddress.landmark
                    streetTxt = tappedAddress.street
                    cityTxt = tappedAddress.city
                    stateTxt = tappedAddress.state
                    zipTxt = tappedAddress.zipCode
                    countryTxt = tappedAddress.country
                    phoneNumber2Txt = tappedAddress.phoneNumber2
                    phoneNumber1Txt = tappedAddress.phoneNumber1
                }
            }
            .onDisappear {
                enableEditAddress = false
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DismissView()
                }
            }
//        }
    }
}

#Preview {
    AddressEditing(addressViewModel: AddressViewModel(), enableEditAddress: .constant(false), showAddAddressView: .constant(false), tappedAddress: .constant(AddressModel(id: "", name: "", buildingName: "", landmark: "", street: "", city: "", state: "", zipCode: "", country: "", phoneNumber1: "", phoneNumber2: "")))
}
