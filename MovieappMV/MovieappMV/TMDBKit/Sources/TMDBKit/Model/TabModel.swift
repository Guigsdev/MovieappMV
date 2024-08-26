//
//  File.swift
//  
//
//  Created by Guillaume Afanou on 21/08/2024.
//

import SwiftUI

public enum Tab: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case topRated = "Top Rated"
    case popular = "Popular"
}

public struct TabModel: Identifiable {
    public var id: Tab
    // Size and the minX properties used for dynamic sizing and positionning the indicator in the tabbar
    public var size: CGSize = .zero
    public var minX: CGFloat = .zero
    
    public init(id: Tab, size: CGSize = .zero, minX: CGFloat = .zero) {
        self.id = id
        self.size = size
        self.minX = minX
    }
   
}
