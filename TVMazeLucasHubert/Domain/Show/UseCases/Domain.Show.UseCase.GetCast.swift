//
//  Domain.Show.UseCase.GetCast.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension Domain.Show.UseCase {
    public struct GetCast {
        public let repository: ShowRepositoryProtocol
        
        public init(repository: ShowRepositoryProtocol) {
            self.repository = repository
        }
        
        public func execute(showId: Int) async throws -> [Domain.Show.Model.Cast] {
            return try await repository.getCast(showId: showId)
        }
    }
}
