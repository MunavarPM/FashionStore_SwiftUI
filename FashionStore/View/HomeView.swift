//
//  HomeView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 06/10/23.
//

import SwiftUI

struct HomeView: View {
    private let categories = ["Dresses", "Jackets", "Jeans", "Shoese"]
    @State private var search: String = ""
    @State private var selectedIndex: Int = 0
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Light")
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        TagLineView()
                            .padding(.leading, 2)
                        
                        HStack {
                            HStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .padding()
                                TextField("Search...", text: $search)
                                    .font(.custom("PlayfairDisplay-Regular", size: 17))
                                    .autocapitalization(.none)
                                    .frame(height: 52)
                            }
                            .frame(height: 52)
                            .background(Color("Dark").cornerRadius(32)
                                .opacity(0.1))
                            
                            .overlay {
                                Capsule()
                                    .stroke(Color.white.opacity(1.0))
                                    .blendMode(.overlay)
                            }
                            Button {
                                print("sort")
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color("Dark"))
                                        .cornerRadius(10)
                                        .frame(width: 45, height: 45)
                                        .overlay {
                                            VStack(alignment: .center, spacing: 7) {
                                                HStack(spacing: -0.6) {
                                                    Circle()
                                                        .frame(width: 7, height: 7)
                                                        .offset(x: 0)
                                                    Rectangle()
                                                        .frame(width: 13, height: 3)
                                                        .offset(x: 5)
                                                        .opacity(0.5)
                                                }
                                                HStack(spacing: -0.6) {
                                                    Rectangle()
                                                        .frame(width: 13, height: 3)
                                                        .offset(x: 0)
                                                        .opacity(0.5)
                                                    Circle()
                                                        .frame(width: 7, height: 7)
                                                        .offset(x: 5)
                                                }
                                            }
                                            .foregroundStyle(Color("Light"))
                                        }
                                }
                            }
                            
                        }
                        .padding(.horizontal, 10)
                        
                        HStack {
                            Image(.onBoarding2)
                                .resizable()
                                .frame(width: 120, height: 100)
                                .cornerRadius(20)
                            VStack {
                                Text("Alex Arigato")
                                    .font(.custom("PlayfairDisplay-Regular", size: 20))
                                Text("Cleam 90's Jacket")
                                    .font(.custom("PlayfairDisplay-Regular", size: 15))
                                    .foregroundStyle(.gray)
                                Text("$ 240")
                                    .font(.custom("PlayfairDisplay-Regular", size: 20))
                            }
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.right.square")
                                    .foregroundStyle(Color("Dark"))
                            }
                        }
                        .padding(.leading, 50)
                        
                        
                        /// Categories
                        Text("Categories")
                            .font(.custom("PlayfairDisplay-Bold", size: 26))
                            .fontWeight(.bold)
                            .offset(CGSize(width: 10.0, height: 10.0))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count) { i in
                                    CapsuleButton(isActive: i == selectedIndex, text: categories[i])
                                        .containerRelativeFrame(.horizontal) /// New system that for bring the image in to center
                                    .onTapGesture {
                                        selectedIndex = i
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 4, leading: 10, bottom: 10, trailing: 20))
                        }
                        HStack {
                            Text("Top Dressess")
                                .font(.custom("PlayfairDisplay-Bold", size: 26))
                                .fontWeight(.bold)
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("View All")
                                    .font(.custom("PlayfairDisplay-Regular", size: 16))
                                    .foregroundStyle(.gray)
                            }

                        }
                        .padding(.horizontal)
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
                        MenuBar()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("show settings")
                    } label: {
                        Image(.onBoarding3)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    HomeView()
}

struct MenuBar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("Dark"))
                .frame(width: 40, height: 40)
                .overlay {
                    VStack(alignment: .center, spacing: 4.5) {
                        Rectangle()
                            .frame(width: 12, height: 3)
                            .offset(x: 5)
                        Rectangle()
                            .frame(width: 20, height: 3)
                        Rectangle()
                            .frame(width: 12, height: 3)
                            .offset(x: -5)
                    }
                    .foregroundStyle(Color("Light"))
                }
        }
    }
}

struct TagLineView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 20)
            Text("Welcome,")
                .font(.custom("PlayfairDisplay-Bold", size: 28))
                .foregroundStyle(Color("Dark"))
            Text("Our Fashion App")
                .font(.custom("PlayfairDisplay-Regular", size: 25))
                .foregroundStyle(Color("Dark"))
        }
        .padding()
    }
}

struct CapsuleButton: View {
    let isActive: Bool
    let text: String
    var body: some View {
        HStack {
            HStack {
                Text(text)
                    .font(.custom("PlayfairDisplay-Bold", size: 15))
                    .foregroundStyle(Color(isActive ? "Light": "Dark"))
                    .frame(width: 85, height: 18)
                    .padding(.vertical, 10)
                
            }
            .background(Color(isActive ? "Dark" : "Light"))
            .clipShape(Capsule())
        }
    }
}
