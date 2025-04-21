//
//  Presenter.Show.Screen.Favorites.Factory.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation

extension Presenter.Show.Screens.Favorites {
    struct Factory {
        @MainActor
        static func makeViewModel() -> Presenter.Show.Screens.Favorites.ViewModel {
            let dispather = DataSource.Dispatcher()
            let repository = DataSource.Show.Repository(dispatcher: dispather)
            let getShowByIdUseCase = Domain.Favorite.UseCase.GetShowById(repository: repository)
            
            return Presenter.Show.Screens.Favorites.ViewModel(getShowByIdUseCase: getShowByIdUseCase)
        }
    }
}
