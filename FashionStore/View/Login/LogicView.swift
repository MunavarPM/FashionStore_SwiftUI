//
//  LogicView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 05/12/23.
//

import SwiftUI

struct LogicView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabBar()
            } else {
                OnBoardingTapView()
            }
        }
    }
}

#Preview {
    LogicView()
}
