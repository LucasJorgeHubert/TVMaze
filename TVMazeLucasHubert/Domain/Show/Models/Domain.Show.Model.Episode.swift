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
        public let url: String
        public let name: String
        public let season: Int
        public let number: Int
        public let type: String
        public let airdate: String
        public let airtime: String
        public let airstamp: String
        public let runtime: Int
        public let rating: Rating?
        public let image: EspisodeImage
        public let summary: String
        public let _links: Links
        
        public func getAirdate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: airdate) ?? nil
        }
    }
    
    public struct Rating: Codable, Hashable {
        public let average: Double
    }
    
    public struct EspisodeImage: Codable, Hashable {
        public let medium: String
        public let original: String
    }
    
    public struct Links: Codable, Hashable {
        public let selfLink: SelfLink
        
        enum CodingKeys: String, CodingKey {
            case selfLink = "self"
        }
    }
    
    public struct SelfLink: Codable, Hashable {
        public let href: String
    }
    
    public struct ShowLink: Codable, Hashable {
        public let href: String
        public let name: String
    }
}
