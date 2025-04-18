//
//  Presenter.Show.Screens.ListShows.DI.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftData

extension Presenter.Show.Screens.ListShows {
    struct DI {
        func makeViewModel(context: ModelContext) -> Presenter.Show.Screens.ListShows.ViewModel {
            let dispatcher: DispatcherProtocol = DataSource.DispatcherMock()
            let repository: ShowRepositoryProtocol = DataSource.Show.Repository(dispatcher: dispatcher)
            let getShowUseCase: Domain.Show.UseCase.GetShows = Domain.Show.UseCase.GetShows(repository: repository)
            let getShowBySearchUseCase: Domain.Show.UseCase.GetShowByName = Domain.Show.UseCase.GetShowByName(repository: repository)
            
            return .init(
                getShowUseCase: getShowUseCase,
                getShowBySearchUseCase: getShowBySearchUseCase,
                context: context
            )
        }
    }
}
