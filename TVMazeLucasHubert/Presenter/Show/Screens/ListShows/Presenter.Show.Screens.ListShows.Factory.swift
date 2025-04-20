//
//  Presenter.Show.Screens.ListShows.Factory.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 19/04/25.
//

import Foundation

extension Presenter.Show.Screens.ListShows {
    struct Factory {
        static func makeViewModel() -> Presenter.Show.Screens.ListShows.ViewModel {
            let dispather = DataSource.DispatcherMock()
            let repository = DataSource.Show.Repository(dispatcher: dispather)
            let getShowUseCase = Domain.Show.UseCase.GetShows(repository: repository)
            let getShowBySearchUseCase = Domain.Show.UseCase.GetShowByName(repository: repository)
            
            return ViewModel(
                getShowUseCase: getShowUseCase,
                getShowBySearchUseCase: getShowBySearchUseCase
            )
        }
    }
}
