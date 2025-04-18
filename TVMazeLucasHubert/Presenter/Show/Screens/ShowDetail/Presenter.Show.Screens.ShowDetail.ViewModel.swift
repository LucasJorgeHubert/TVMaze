//
//  Presenter.Show.Screens.ShowDetail.ViewModel.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftData

extension Presenter.Show.Screens.ShowDetails {
    class ViewModel: ObservableObject {
        @Published var show: Domain.Show.Model.Show
        @Published var episodes: [Domain.Show.Model.Episode] = []
        @Published var cast: [Domain.Show.Model.Cast] = []
        @Published var loading: Bool = false
        
        let getEpisodesUseCase: Domain.Show.UseCase.GetEpisodes
        let getCastUseCase: Domain.Show.UseCase.GetCast
        
        let context: ModelContext
        
        init(
            show: Domain.Show.Model.Show,
            getEpisodesUseCase: Domain.Show.UseCase.GetEpisodes,
            getCastUseCase: Domain.Show.UseCase.GetCast,
            context: ModelContext
        ) {
            self.show = show
            self.getEpisodesUseCase = getEpisodesUseCase
            self.getCastUseCase = getCastUseCase
            self.context = context
        }
        
        func getEpisodes() async throws {
            loading = true
            self.episodes = try await getEpisodesUseCase.execute(showId: show.id)
            loading = false
        }
        
        func getCast() async throws {
            loading = true
            self.cast = try await getCastUseCase.execute(showId: show.id)
            loading = false
        }
        
    }
}
