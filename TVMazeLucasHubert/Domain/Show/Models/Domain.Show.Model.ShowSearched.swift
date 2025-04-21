//
//  Domain.Show.Model.ShowSearched.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation

extension Domain.Show.Model {
    public struct ShowSearched: Codable, Hashable {
        public let score: Double
        public let show: Domain.Show.Model.Show
    }
}
