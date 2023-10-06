//
//  WelcomeView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 03/10/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image(.opening)
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            AppNameView(color: .white)
        }
    }
}

#Preview {
    WelcomeView()
}

struct AppNameView: View {
    var color: Color
    var body: some View {
        VStack {
            Text("Fashion")
                .font(.custom("GreatVibes-Regular", size: 100))
                .foregroundStyle(color)
                .offset(y: 30)
            
            Text("MY LIFE MY STYLE.")
                .font(.custom("PlayfairDisplay-Regular", size: 18))
                .foregroundStyle(color)
                .offset(x: 60, y: -8)
        }
    }
}
