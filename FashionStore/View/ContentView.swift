//
//  ContentView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 21/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AuthViewModel()
    var body: some View {
        if viewModel.userSession != nil {
            TabBar()
        } else {
           OnBoardingTapView()
        }
    }
}

#Preview {
    ContentView()
}
