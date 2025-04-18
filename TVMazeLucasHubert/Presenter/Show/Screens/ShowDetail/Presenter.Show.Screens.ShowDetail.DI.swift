//
//  Presenter.Show.Screens.ShowDetail.DI.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftData

extension Presenter.Show.Screens.ShowDetails {
    struct DI {
        func makeViewModel(context: ModelContext, show: Domain.Show.Model.Show) -> Presenter.Show.Screens.ShowDetails.ViewModel {
            let dispatcher: DispatcherProtocol = DataSource.DispatcherMock()
            let repository: ShowRepositoryProtocol = DataSource.Show.Repository(dispatcher: dispatcher)
            let getEpisodesUseCase: Domain.Show.UseCase.GetEpisodes = Domain.Show.UseCase.GetEpisodes(repository: repository)
            let getCastUseCase: Domain.Show.UseCase.GetCast = Domain.Show.UseCase.GetCast(repository: repository)
            
            return .init(
                show: show,
                getEpisodesUseCase: getEpisodesUseCase,
                getCastUseCase: getCastUseCase,
                context: context
            )
        }
    }
}
