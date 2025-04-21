//
//  Domain.Show.Protocol.Repository.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

public protocol ShowRepositoryProtocol {
    func getShows(page: Int) async throws -> [Domain.Show.Model.Show]
    func getShowsByName(search: String) async throws -> [Domain.Show.Model.ShowSearched]
    func getShowById(id: Int) async throws -> Domain.Show.Model.Show
    func getEpisodes(showId: Int) async throws -> [Domain.Show.Model.Episode]
    func getCast(showId: Int) async throws -> [Domain.Show.Model.Cast]
}
