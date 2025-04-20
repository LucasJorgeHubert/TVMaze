//
//  Domain.Show.UseCase.GetShowByName.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension Domain.Show.UseCase {
    public struct GetShowByName {
        public let repository: ShowRepositoryProtocol
        
        public init(repository: ShowRepositoryProtocol) {
            self.repository = repository
        }
        
        public func execute(search: String) async throws -> [Domain.Show.Model.Show] {
            let shows = try await repository.getShowsByName(search: search)
            let filteredShows: [Domain.Show.Model.Show] = shows.map { $0.show }
            return filteredShows
        }
    }
}
