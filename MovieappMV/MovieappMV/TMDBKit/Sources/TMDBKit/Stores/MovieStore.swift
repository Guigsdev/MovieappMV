//
//  File.swift
//  
//
//  Created by Guillaume Afanou on 18/07/2024.
//

import Foundation
import Observation

@Observable
public class MovieStore {
    
    private let apiManager : APIManager
    
    public var nowPlaying: [Movie] = []
    public var populars: [Movie] = []
    public var topRatedMovies: [Movie] = []
    public var upcomingMovies: [Movie] = []
    
    public init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    public func loadAllMovies() async {
        if #available(iOS 13.0, *) {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.loadNowPlayingMovies() }
                group.addTask { await self.loadPopularMovies() }
                group.addTask { await self.loadTopRatedMovies() }
                group.addTask { await self.loadUpcomingMovies() }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func loadNowPlayingMovies() async {
        do {
            let response: MovieResponseModel = try await apiManager.request(type: MovieEndPoint.nowPlaying)
            self.nowPlaying = response.results
        }catch {
            print(error)
            self.nowPlaying = []
        }
    }
    
    private func loadPopularMovies() async {
        do {
            let response: MovieResponseModel = try await apiManager.request(type: MovieEndPoint.popular)
            self.populars = response.results
        }catch {
            print(error)
            self.populars = []
        }
    }

    private func loadTopRatedMovies() async {
        do {
            let response: MovieResponseModel = try await apiManager.request(type: MovieEndPoint.topRated)
            self.topRatedMovies = response.results
        }catch {
            print(error)
            self.topRatedMovies = []
        }
    }

    private func loadUpcomingMovies() async {
        do {
            let response: MovieResponseModel = try await apiManager.request(type: MovieEndPoint.upcoming)
            self.upcomingMovies = response.results
        }catch {
            print(error)
            self.upcomingMovies = []
        }
    }

}
