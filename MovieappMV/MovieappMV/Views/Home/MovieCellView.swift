//
//  MovieCellView.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 19/07/2024.
//

import SwiftUI
import TMDBKit
import Kingfisher

struct MovieCellView: View {
    let movie: Movie
    let index: Int
    let width: CGFloat
    let height: CGFloat
    let displayNumber: Bool 

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(movie.posterPath?.imageURL)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            
            if displayNumber {
                // TODO: Change offset in order to have number at the right place
                VStack(alignment: .leading) {
                    Text("\(index)")
                        .font(.custom("Montserrat-SemiBold", size: 96))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    MovieCellView(movie: .dummy, index: 1, width: 144, height: 210, displayNumber: false)
}
