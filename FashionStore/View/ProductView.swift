//
//  ProductView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 11/10/23.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color("Light")
                        .ignoresSafeArea(.all)
                    VStack {
                        Image(.modelSH)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.top)
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            print("MenuBar pressed")
                        }
                    }label: {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("Light"))
                                .padding(15)
                                .background(Color("Dark"))
                                .clipShape(Circle())
                            
                        })
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            print("MenuBar pressed")
                        }
                    }label: {
                        Button(action: {
                            
                        }, label: {
                            ZStack {
                                Image(systemName: "bag")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("Dark"))
                                    .padding(10)
                                    .background(Color("Light"))
                                .clipShape(Circle())
//                                Text("1")
//                                    .foregroundStyle(.red)
//                                    .bold()
//                                    .padding(.trailing)
                            }
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    ProductView()
}
