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
            RootScreen()
        }
        .modelContainer(for: Domain.Favorite.Model.FavoriteItem.self)
    }
}

struct RootScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let injector = Presenter.Show.DependencyInjector(context: modelContext)
        
        return Presenter.Show.TabBar.Screen()
            .environmentObject(injector)
    }
}
