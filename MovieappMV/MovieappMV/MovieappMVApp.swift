//
//  MovieappMVApp.swift
//  MovieappMV
//
//  Created by Guillaume Afanou on 18/07/2024.
//

import SwiftUI
import TMDBKit

@main
struct MovieappMVApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashView()
            }
            .environment(MovieStore(apiManager: APIManager()))
        }
    }
}
