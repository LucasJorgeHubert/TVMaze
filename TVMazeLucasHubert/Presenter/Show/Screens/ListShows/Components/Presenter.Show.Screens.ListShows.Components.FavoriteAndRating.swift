//
//  Presenter.Show.Screens.ListShows.Components.FavoriteAndRating.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI
import SwiftData

extension Presenter.Show.Screens.ListShows.Components {
    struct FavoriteAndRating: View {
        @ObservedObject var viewModel: Presenter.Show.Screens.ListShows.ViewModel
        @Query var favorites: [Domain.Favorite.Model.FavoriteItem]
        var show: Domain.Show.Model.Show
        
        var body: some View {
            VStack {
                Button {
                    Task {
                        do {
                            if viewModel.isFavorite(show, favorites: favorites) {
                                try viewModel.removeFromFavorite(show)
                            } else {
                                try viewModel.addToFavorite(show)
                            }
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    if viewModel.isFavorite(show, favorites: favorites) {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
                
                Spacer()
                
                VStack {
                    if show.rating.average != nil {
                        Image(systemName: "star")
                            .foregroundStyle(.yellow.opacity((show.rating.average ?? 0.0) / 10))
                        Text("\(String(format: "%.1f", show.rating.average ?? 0.0))")
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}
