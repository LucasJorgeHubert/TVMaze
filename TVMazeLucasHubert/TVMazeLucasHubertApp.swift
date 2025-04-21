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
    @State private var showHome = false
    
    var body: some Scene {
        WindowGroup {
            if !KeychainService.shared.hasSavedPIN() {
                Presenter.Show.TabBar.Screen()
            } else if !showHome {
                Presenter.Pin.Login.Screen(showHome: $showHome)
            } else {
                Presenter.Show.TabBar.Screen()
            }
        }
        .modelContainer(for: Domain.Favorite.Model.FavoriteItem.self)
    }
}
