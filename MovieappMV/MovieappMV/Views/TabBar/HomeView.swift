import SwiftUI
import TMDBKit

struct HomeView: View {
    
    @Environment(MovieStore.self) private var movieStore
    
    let columns = [GridItem(), GridItem(), GridItem()]

    @State private var tabs: [TabModel] = [
        .init(id: Tab.nowPlaying),
        .init(id: Tab.upcoming),
        .init(id: Tab.topRated),
        .init(id: Tab.popular)
    ]
    @State private var activeTab: Tab = .nowPlaying
    @State private var mainViewScrollState: Tab?
    @State private var tabBarScrollState: Tab?
    @State private var progress: CGFloat = .zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            headerView
            topMovieListView
            
            customTabBar()
                .padding(.top, 0)
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(tabs) { tab in
                            ZStack {
                                Color.clear
                                    .frame(width: size.width, height: size.height)
                                
                                // TODO: FIX lag when scroll the list
                                ScrollView(.vertical) {
                                    LazyVGrid(columns: columns) {
                                        ForEach(currentMovies.indices, id: \.self) { index in
                                            MovieCellView(movie: currentMovies[index], index: index + 1, width: 100, height: 145, displayNumber: false)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .rect { rect in
                        progress = -rect.minX / size.width
                    }
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue {
                        withAnimation(.snappy) {
                            tabBarScrollState = newValue
                            activeTab = newValue
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
        .background(Color("darkBg"))
        .onAppear {
            Task {
                await self.movieStore.loadAllMovies()
            }
        }
    }
    
    private var currentMovies : [Movie] {
        switch activeTab {
        case .nowPlaying:
            return movieStore.nowPlaying
        case .popular:
            return movieStore.populars
        case .topRated:
            return movieStore.topRatedMovies
        case .upcoming:
            return movieStore.upcomingMovies
        }
    }
    
    // MARK: HeaderView
    var headerView: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("What do you want to watch ?")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-SemiBold", size: 18.0))
                Spacer()
            }
            
            SearchPlaceholderView(text: "Search")
                .roundedStrokedView(
                    cornerRadius: 21.0,
                    strokeColor: Color("dark_gray_home"),
                    lineWidth: 1
                )
        }
    }
    
    // MARK: Top Movie List View
    var topMovieListView: some View {
        // TODO: FIX lag when scroll the list
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 25) {
                ForEach(Array(movieStore.nowPlaying.prefix(5).enumerated()), id: \.offset) { index, movie in
                    MovieCellView(movie: movie, 
                                  index: index + 1,
                                  width: 144, 
                                  height: 210,
                                  displayNumber: true)
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 250)
    }
    
    // MARK: Dynamic Scrollable Tab Bar
    @ViewBuilder
    func customTabBar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach($tabs) { $tab in
                    Button(action: {
                        withAnimation(.snappy) {
                            activeTab = tab.id
                            tabBarScrollState = tab.id
                            mainViewScrollState = tab.id
                        }
                    }) {
                        Text(tab.id.rawValue)
                            .padding(.vertical, 12)
                            .foregroundStyle(activeTab == tab.id ? Color.white : .gray)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .rect { rect in
                        tab.size = rect.size
                        tab.minX = rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }), anchor: .center)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.white.opacity(0.0))
                    .frame(height: 1)
                
                let inputRange = tabs.indices.compactMap { return CGFloat($0) }
                let outputRange = tabs.compactMap { return $0.size.width }
                let outputPositionRange = tabs.compactMap { return $0.minX }
                let indicatorWidth = progress.interpolate(inputRange: inputRange,
                                                          outputRange: outputRange)
                let indicatorPosition = progress.interpolate(inputRange: inputRange, 
                                                             outputRange: outputPositionRange)
                Rectangle()
                    .fill(Color("dark_gray_home"))
                    .frame(width: indicatorWidth, height: 4)
                    .offset(x: indicatorPosition)
            }
            .clipped()
        }
        .safeAreaPadding(.horizontal, 10)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
        .environment(MovieStore(apiManager: APIManager()))
}
