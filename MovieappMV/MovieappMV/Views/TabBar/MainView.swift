import SwiftUI
import UIKit

struct MainView: View {
    
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            homeTabView
            searchTabView
            watchListTabView
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color("darkBg"), for: .tabBar)
        .tint(Color("lightBlue"))
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color("darkStroke"))
        })
    }
    
    private var homeTabView: some View {
        HomeView()
            .tabItem {
                selection == 0 ?                   Image("home_selected")
:                   Image("home")

              Text("Home")
            }
            .tag(0)
    }
    
    private var searchTabView: some View {
        SearchView()
            .tabItem {
                selection == 1 ?                   Image("search_tab_selected")
:                   Image("search_tab")
              Text("Search")
            }
            .tag(1)
    }
    
    private var watchListTabView: some View {
        WatchListView()
            .tabItem {
                selection == 2 ?                   Image("save_selected")
:                   Image("save")
              Text("Watch List")
            }
            .tag(2)
    }
}

#Preview {
    MainView()
}
