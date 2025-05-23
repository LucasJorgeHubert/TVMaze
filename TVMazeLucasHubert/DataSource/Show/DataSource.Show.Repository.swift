//
//  DataSource.Show.Repository.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension DataSource.Show {
    public struct Repository: ShowRepositoryProtocol {
        private let dispatcher: DispatcherProtocol
        
        init(dispatcher: DispatcherProtocol) {
            self.dispatcher = dispatcher
        }
        
        typealias router = DataSource.Show.APIRouter
        
        public func getShows(page: Int) async throws -> [Domain.Show.Model.Show] {
            return try await dispatcher.request(apiRouter: router.getShows(page: page))
        }
        
        public func getShowsByName(search: String) async throws -> [Domain.Show.Model.ShowSearched] {
            return try await dispatcher.request(apiRouter: router.getShowsByName(search: search))
        }
        
        public func getEpisodes(showId: Int) async throws -> [Domain.Show.Model.Episode] {
            return try await dispatcher.request(apiRouter: router.getEpisodes(showId: showId))
        }
        
        public func getCast(showId: Int) async throws -> [Domain.Show.Model.Cast] {
            return try await dispatcher.request(apiRouter: router.getCast(showId: showId))
        }
        
        public func getShowById(id: Int) async throws -> Domain.Show.Model.Show {
            return try await dispatcher.request(apiRouter: router.getShowById(id: id))
        }
    }
}
