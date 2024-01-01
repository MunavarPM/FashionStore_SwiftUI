//
//  Bootcamb.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 29/12/23.
//

import SwiftUI

struct Bootcamb: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                
            }
    }
}

struct myStruct {
    var title: String
}

extension Bootcamb {
    private func runTest() {
        print("Test One")
    }
    private func structTestOne() {
        
        let objA = myStruct(title: "Starting Test")
        print("objA", objA.title)
        
        var objB = objA
        print("Swapped")
        print("objB", objB.title)
        
        objB.title = "Second Test"
        print("title was changed")
        
        print("objA", objA.title)
        print("objA", objB.title)
    
    }
}

#Preview {
    Bootcamb()
}
