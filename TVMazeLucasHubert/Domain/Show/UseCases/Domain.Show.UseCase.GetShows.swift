//
//  Domain.Show.UseCase.GetShows.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension Domain.Show.UseCase {
    public struct GetShows {
        public let repository: ShowRepositoryProtocol
        
        public init(repository: ShowRepositoryProtocol) {
            self.repository = repository
        }
        
        public func execute(page: Int) async throws -> [Domain.Show.Model.Show] {
            return try await repository.getShows(page: page)
        }
    }
}
