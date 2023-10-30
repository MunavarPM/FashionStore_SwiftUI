//
//  BTHeart.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 15/10/23.
//

import SwiftUI

struct BTHeart: View {
    @Binding var fav: Bool
    let action: () -> ()
    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation(.easeInOut){
                    fav.toggle()
                }
                print("Button was tapped")
                action()
            } label: {
                Image(systemName: fav ? "heart.fill" : "heart" )
                    .font(.title3)
                    
                    .foregroundStyle(.black)
                    .cornerRadius(50)
                    .padding(7)
                    .background(Circle())
                    .foregroundStyle(.white)
                    .onTapGesture {
                        fav.toggle()
                    }
            }
        }
    }
}

//#Preview {
//    BTHeart(fav: $Binding<Bool>, action: {
//        
//    })
//}
