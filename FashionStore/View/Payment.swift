//
//  Payment.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 29/10/23.
//

import SwiftUI

struct Payment: View {
    @EnvironmentObject var cartVm: ProductManagerViewModel
    var body: some View {
            VStack {
                Text("Payment")
                    .font(.custom("PlayfairDisplay-Bold", size: 32).bold())
                    .offset(x: -110)
                Spacer()
                VStack(alignment: .leading, spacing: 25) {
                    
                    
                    NavigationLink {
                        RazorPayView(productManagerViewModel: cartVm, totalPrice: 1090)
                    } label: {
                        PaymentOptionView(systemImage: nil, image: "razorpay", text: "Razorpay")
                    }
                    PaymentOptionView(systemImage: "plus.circle", image: nil, text: "Add Card")
                    
                    Spacer()
                }
                .padding(.top)
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissView()
                }
            })
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    Payment()
}

struct PaymentOptionView: View {
    @State var isTap = false
//    @Binding var isShow: Bool
    let systemImage: String?
    let image: String?
    let text: String?
    var body: some View {
        NavigationLink {
//            RazorPayView(totalPrie: 10000, name: <#String#>)
        } label:{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(isTap ? "Dark":"Light"))
                    .frame(width: 370, height: 80)
                    .shadow(radius: 4, x: 3, y: 3)
            }.overlay {
                HStack(spacing: 20) {
                    if let systemImage = systemImage {
                        Image(systemName: systemImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundStyle(.gray)
                    } else if let image = image {
                        Image(image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    if systemImage != nil {
                        Text(text ?? "Paypal")
                            .foregroundStyle(.gray)
                            .font(.custom("PlayfairDisplay-Bold", size: 20))
                    } else if image != nil {
                        Text(text ?? "Paypal")
                            .foregroundStyle(Color(isTap ? "Light":"Dark"))
                            .font(.custom("PlayfairDisplay-Bold", size: 20).bold())
                    }
                    Spacer()
                    Button {} label: {
                        Image(systemName: isTap ? "circle.fill" : "circle")
                            .foregroundStyle(Color(isTap ? "Light":"Dark"))
                    }
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                isTap.toggle()
    //            isShow.toggle()
            }
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 2).opacity(0.1))
        }
    }
}
