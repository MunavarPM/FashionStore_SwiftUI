//
//  OnBoardingTapView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI

struct OnBoardingTapView: View {
    @State private var currentPage = 0
    @State private var isOnboardingComplete = false
    @State private var welcomeViewPresent = true
    
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        if welcomeViewPresent {
            WelcomeView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        welcomeViewPresent = false
                    }
                }
        } else {
            if !isOnboardingComplete {
                TabView(selection: $currentPage) {
                    OnBoarding(image: .onBoarding1,percentage: "20%", text1: " Discount", text2: "New Arrival Product", footer: "Publish up your selfies to make yourself\nmore beautiful with your app.") .tag(0)
                    OnBoarding(image: .onBoarding2, text1: "Take Advantage", text2: "of the Offer Shopping", footer: "Explore the artistry of fashion with our\n handpicked dress collection.").tag(1)
                    OnBoarding(image: .onBoarding3, text1: "All Types Offers", text2: " Within Your Reach", footer: "Step into a world of fashion, where every dress tells a unique story.").tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onChange(of: currentPage) { newValue, _ in
                    if newValue == 2 {
                        isOnboardingComplete = true
                    }
                }
                .overlay(skipButton, alignment: .bottomTrailing)
            } else {
                Group {
                    if viewModel.userSession != nil {
                        HomeView()
                    } else {
                        Signin()
                    }
                }
            }
        }
    }
    var skipButton: some View {
        Button("Skip") {
            isOnboardingComplete = true
        }
        .foregroundStyle(.black)
        .padding()
    }
}

#Preview {
    OnBoardingTapView()
}
