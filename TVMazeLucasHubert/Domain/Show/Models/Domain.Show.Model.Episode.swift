//
//  Domain.Show.Model.Episode.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension Domain.Show.Model {
    public struct Episode: Codable, Hashable, Identifiable {
        public let id: Int
        public let name: String
        public let season: Int
        public let number: Int
        public let airdate: String
        public let image: EspisodeImage
        public let summary: String
        
        public func getAirdate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: airdate) ?? nil
        }
    }
    
    public struct EspisodeImage: Codable, Hashable {
        public let medium: String
        public let original: String
    }
}
