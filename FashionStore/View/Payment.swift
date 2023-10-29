//
//  Payment.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 29/10/23.
//

import SwiftUI

struct Payment: View {
    @State var isTap = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Payment")
                    .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                    .offset(x: -110)
                Spacer()
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(isTap ? "Dark":"Light"))
                            .frame(width: 370, height: 80)
                            .shadow(radius: 4, x: 5, y: 6)
                    }.overlay {
                        HStack(spacing: 20) {
                            Image(.modelFT)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            Text("Paypal")
                                .foregroundStyle(Color(isTap ? "Light":"Dark"))
                                .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                            Spacer()
                            Button {
                                isTap.toggle()
                            } label: {
                                Image(systemName: isTap ? "circle.fill" : "circle")
                                    .foregroundStyle(Color(isTap ? "Light":"Dark"))
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.1))
                    Spacer()
                }
                .padding(.top)
            }
            
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissView()
                }
            })
        }
    }
}


#Preview {
    Payment()
}
