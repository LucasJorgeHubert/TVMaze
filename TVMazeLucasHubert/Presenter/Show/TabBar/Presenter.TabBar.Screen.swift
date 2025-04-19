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
        @Environment(\.modelContext) private var context
        
        var body: some View {
            TabView {
                Presenter.Show.Screens.ListShows.Screen(viewModel: Presenter.Show.Screens.ListShows.Factory.makeViewModel())
                .tabItem { Image(systemName: "list.dash") }
                
                GroupBox {
                    Text("Favorites")
                }
                .tabItem { Image(systemName: "star") }
            }
            .onAppear {
            }
        }
    }
}

#Preview {
    PreviewWrapper {
        Presenter.Show.TabBar.Screen()
    }
}
