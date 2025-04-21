//
//  Domain.Show.UseCase.getShowById.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation

extension Domain.Favorite.UseCase {
    public struct GetShowById {
        public let repository: ShowRepositoryProtocol
        
        public init(repository: ShowRepositoryProtocol) {
            self.repository = repository
        }
        
        public func execute(id: Int) async throws -> Domain.Show.Model.Show {
            return try await repository.getShowById(id: id)
        }
    }
}
