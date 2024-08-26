//
//  String.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 26/08/2024.
//

import Foundation

extension String {
    var imageURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/original/\(self)")
    }

}
