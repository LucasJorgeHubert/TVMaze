//
//  Presenter.TabBar.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import SwiftUI
import SwiftData

extension Presenter.Show.TabBar {
    struct Screen: View {
        var body: some View {
            TabView {
                Presenter.Show.Screens.ListShows.ScreenWrapper()
                .tabItem { Image(systemName: "list.dash") }
                
                GroupBox {
                    Text("Favorites")
                }
                .tabItem { Image(systemName: "star") }
            }
        }
    }
}

#Preview {
    PreviewWrapper {
        Presenter.Show.TabBar.Screen()
    }
}
