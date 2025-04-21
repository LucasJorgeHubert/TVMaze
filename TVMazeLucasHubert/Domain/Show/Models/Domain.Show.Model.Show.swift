//
//  Domain.Show.Model.Show.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension Domain.Show.Model {
    public struct Show: Codable, Hashable, Identifiable {
        public let id: Int
        let url: String
        let name, type, language: String
        let genres: [String]
        let status: String
        let runtime, averageRuntime: Int?
        let premiered, ended: String?
        let officialSite: String?
        let schedule: Schedule
        let rating: ShowRating
        let weight: Int
        let network: Network?
        let externals: Externals
        let image: ShowImage
        let summary: String?
        let updated: Int
        
        public func getDatePremiered() -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: premiered ?? "") ?? Date()
        }
        
        public func getDateEnded() -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: ended ?? "") ?? Date()
        }
        

    }
    
    // MARK: - Externals
    struct Externals: Codable, Hashable {
        let tvrage, thetvdb: Int?
        let imdb: String?
    }
    
    // MARK: - Image
    struct ShowImage: Codable, Hashable {
        let medium, original: String
    }
    
    // MARK: - SelfClass
    struct SelfLinkShow: Codable, Hashable {
        let href: String
    }
    
    // MARK: - Previousepisode
    struct PreviousEpisode: Codable, Hashable {
        let href: String
        let name: String
    }
    
    // MARK: - Network
    struct Network: Codable, Hashable {
        let id: Int
        let name: String
        let country: ShowCountry?
        let officialSite: String?
    }
    
    // MARK: - Country
    struct ShowCountry: Codable, Hashable {
        let name, code, timezone: String
    }
    
    // MARK: - Rating
    struct ShowRating: Codable, Hashable {
        let average: Double?
    }
    
    // MARK: - Schedule
    struct Schedule: Codable, Hashable {
        let time: String
        let days: [String]
    }
}
