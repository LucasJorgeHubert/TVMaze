//
//  Presenter.Show.Screens.ShowDetails.ViewModel.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 19/04/25.
//

import Foundation

extension Presenter.Show.Screens.ShowDetails {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var episodes: [Int : [Domain.Show.Model.Episode]] = [:]
        @Published var cast: [Domain.Show.Model.Cast] = []
        
        let getEpisodeUseCase: Domain.Show.UseCase.GetEpisodes
        let getCastUseCase: Domain.Show.UseCase.GetCast
        let show: Domain.Show.Model.Show
        
        init(getEpisodeUseCase: Domain.Show.UseCase.GetEpisodes, getCastUseCase: Domain.Show.UseCase.GetCast, show: Domain.Show.Model.Show) {
            self.show = show
            self.getEpisodeUseCase = getEpisodeUseCase
            self.getCastUseCase = getCastUseCase
            Task {
                try? await getEpisodes(showId: show.id)
            }
            Task {
                try? await getCast(showId: show.id)
            }
        }
        
        @MainActor
        func getEpisodes(showId: Int) async throws {
            let eps = try await getEpisodeUseCase.execute(showId: showId)
            let dict = Dictionary(grouping: eps) { $0.season }
            self.episodes = dict
        }
        
        @MainActor
        func getCast(showId: Int) async throws {
            let cast = try await getCastUseCase.execute(showId: showId)
            self.cast = cast
        }
        
    }
}

