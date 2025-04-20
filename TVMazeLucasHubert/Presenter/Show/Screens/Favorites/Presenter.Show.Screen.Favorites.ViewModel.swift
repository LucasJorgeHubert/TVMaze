//
//  Presenter.Show.Screen.Favorites.ViewModel.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftData

extension Presenter.Show.Screens.Favorites {
    class ViewModel: ObservableObject {
        
        let getShowByIdUseCase: Domain.Favorite.UseCase.GetShowById
        
        init(getShowByIdUseCase: Domain.Favorite.UseCase.GetShowById) {
            self.getShowByIdUseCase = getShowByIdUseCase
        }
        
        func getShow(id: Int) async throws -> Domain.Show.Model.Show {
            return try await getShowByIdUseCase.execute(id: id)
        }
    }
}
