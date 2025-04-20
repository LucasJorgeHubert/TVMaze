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
        
        let getEpisodeUseCase: Domain.Show.UseCase.GetEpisodes
        let show: Domain.Show.Model.Show
        
        init(getEpisodeUseCase: Domain.Show.UseCase.GetEpisodes, show: Domain.Show.Model.Show) {
            self.show = show
            self.getEpisodeUseCase = getEpisodeUseCase
            Task {
                try? await getEpisodes(showId: show.id)
            }
        }
        
        @MainActor
        func getEpisodes(showId: Int) async throws {
            let eps = try await getEpisodeUseCase.execute(showId: showId)
            let dict = Dictionary(grouping: eps) { $0.season }
            self.episodes = dict
            print(eps)
        }
        
    }
}

