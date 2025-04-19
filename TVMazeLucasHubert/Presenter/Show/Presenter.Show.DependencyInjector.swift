//
//  Presenter.Show.DependencyInjector.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftUI
import SwiftData

extension Presenter.Show {
    class DependencyInjector: ObservableObject {
        let context: ModelContext
        let getShowUseCase: Domain.Show.UseCase.GetShows
        let getShowBySearchUseCase: Domain.Show.UseCase.GetShowByName
        let getEpisodesUseCase: Domain.Show.UseCase.GetEpisodes
        let getCastUseCase: Domain.Show.UseCase.GetCast
        
        init(context: ModelContext) {
            self.context = context
            let dispatcher: DispatcherProtocol = DataSource.DispatcherMock()
            let repository: ShowRepositoryProtocol = DataSource.Show.Repository(dispatcher: dispatcher)
            
            self.getShowUseCase = Domain.Show.UseCase.GetShows(repository: repository)
            self.getShowBySearchUseCase = Domain.Show.UseCase.GetShowByName(repository: repository)
            self.getEpisodesUseCase = Domain.Show.UseCase.GetEpisodes(repository: repository)
            self.getCastUseCase = Domain.Show.UseCase.GetCast(repository: repository)
        }
    }
}
