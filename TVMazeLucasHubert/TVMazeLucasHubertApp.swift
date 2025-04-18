//
//  TVMazeLucasHubertApp.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import SwiftUI
import SwiftData

@main
struct TVMazeLucasHubertApp: App {
    var body: some Scene {
        WindowGroup {
            Presenter.Show.TabBar.Screen()
        }
        .modelContainer(for: Domain.Favorite.Model.FavoriteItem.self)
    }
}
