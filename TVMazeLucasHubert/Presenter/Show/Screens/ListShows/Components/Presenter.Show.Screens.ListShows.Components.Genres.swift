//
//  Presenter.Show.Screens.ListShows.Components.Genres.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI

extension Presenter.Show.Screens.ListShows.Components {
    struct Genres: View {
        @ObservedObject var viewModel: Presenter.Show.Screens.ListShows.ViewModel
        var show: Domain.Show.Model.Show
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(show.genres, id: \.self) { g in
                        Text(g)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background {
                                Capsule(style: .circular).fill(viewModel.colorForGenre(g))
                            }
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
}
