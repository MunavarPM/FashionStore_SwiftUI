//
//  CustomTF.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI

struct CustomTF: View {
    
    var hint: String
    var isPassword: Bool = false
    
    @Binding var value: String
    @State private var showPassword: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                if isPassword {
                    Group {
                        /// Show the password for user
                        if showPassword {
                            TextField(hint, text: $value)
                        } else {
                            SecureField(hint, text: $value)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                }
                Divider()
            }
            .overlay(alignment: .trailing) {
                if isPassword {
                    Button {
                        withAnimation {
                            showPassword.toggle()
                        }
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    }
                }
            }
        }
    }
}
//struct CustomTF: View {
//    
//    var hint: String
//    var isPassword: Bool = false
//    
//    @Binding var value: String
//    @State private var isSecureTextEntry: Bool = true
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 8) {
//            VStack(alignment: .leading, spacing: 8) {
//                if isPassword {
//                    if isSecureTextEntry {
//                        SecureField(hint, text: $value)
//                    } else {
//                        TextField(hint, text: $value)
//                    }
//                } else {
//                    TextField(hint, text: $value)
//                }
//                Divider()
//            }
//            .overlay(alignment: .trailing) {
//                if isPassword {
//                    Button {
//                        isSecureTextEntry.toggle()
//                    } label: {
//                        Image(systemName: isSecureTextEntry ? "eye.slash" : "eye")
//                            .foregroundStyle(.gray)
//                            .padding(10)
//                            .contentShape(Circle())
//                    }
//                }
//            }
//        }
//    }
//}
