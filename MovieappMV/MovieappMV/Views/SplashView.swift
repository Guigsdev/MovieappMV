//
//  SplashView.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 18/07/2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                MainView()
            } else {
                Image("popcorn")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 189, height: 189)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("darkBg"))
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
