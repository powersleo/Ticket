//
//  MainPageView.swift
//  Ticket
//
//  Created by Leo Powers on 7/6/23.
//

import SwiftUI

struct MainPageView: View {
    @State private var selectedTab = 0
    @StateObject var postViewModel = PostViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            PostView().environmentObject(postViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)

            UserView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
