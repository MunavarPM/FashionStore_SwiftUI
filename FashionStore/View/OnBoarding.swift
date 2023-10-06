//
//  OnBoarding.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 05/10/23.
//

import SwiftUI

struct OnBoarding: View {
    
    var image: UIImage
    var percentage: String?
    var text1: String
    var text2: String
    var footer: String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 550)
                    .cornerRadius(30)
                    .clipShape(CustomCardShape())
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text(percentage ?? "")
                        .font(.system(.title, design: .serif))
                        .fontWeight(.bold)
                    +
                    Text(text1)
                        .font(.custom("PlayfairDisplay-Bold", size: 25))
                        .fontWeight(.bold)
                    
                    Text(text2)
                        .font(.custom("PlayfairDisplay-Regular", size: 25))
                        .fontWeight(.bold)
                    
                    Text(footer)
                        .font(.custom("PlayfairDisplay-Regular", size: 12))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OnBoarding(image: .onBoarding1,percentage: "20%", text1: " Discount", text2: "New Arrival Product", footer: "Publish up your selfies to make yourself\nmore beautiful with your app")
}

struct CustomCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: rect.width, y: 0)
            
            let pt3 = CGPoint(x: rect.width, y: rect.height - 30)
            let pt4 = CGPoint(x: 0, y: rect.height)
            path.move (to: pt4)
            path.addArc (tangent1End: pt1, tangent2End: pt2, radius: 40)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 40)
            path.addArc (tangent1End: pt3, tangent2End: pt4, radius: 40)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 40)
        }
    }
}
