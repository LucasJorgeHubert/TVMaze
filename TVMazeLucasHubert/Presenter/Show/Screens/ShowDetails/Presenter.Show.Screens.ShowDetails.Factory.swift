//
//  Presenter.Show.Screens.ShowDetails.Factory.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 19/04/25.
//

import Foundation

extension Presenter.Show.Screens.ShowDetails {
    struct Factory {
        @MainActor 
        static func makeViewModel(show: Domain.Show.Model.Show) -> Presenter.Show.Screens.ShowDetails.ViewModel {
            let dispather = DataSource.DispatcherMock()
            let repository = DataSource.Show.Repository(dispatcher: dispather)
            let getEpisodeUseCase = Domain.Show.UseCase.GetEpisodes(repository: repository)
            let getCastUseCase = Domain.Show.UseCase.GetCast(repository: repository)
            
            return Presenter.Show.Screens.ShowDetails.ViewModel(
                getEpisodeUseCase: getEpisodeUseCase,
                getCastUseCase: getCastUseCase,
                show: show
            )
        }
    }
}
