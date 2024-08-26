//
//  SearchPlaceholderView.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 19/07/2024.
//

import SwiftUI

struct SearchPlaceholderView: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.custom("Poppins-Regular", size: 14.0))
                .foregroundColor(Color("darkStroke"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
        }
        .padding(.horizontal, 24)
        .frame(height: 42.0)
        .background(Color("dark_gray_home"))
    }
}

#Preview {
    SearchPlaceholderView(text: "search")
}
