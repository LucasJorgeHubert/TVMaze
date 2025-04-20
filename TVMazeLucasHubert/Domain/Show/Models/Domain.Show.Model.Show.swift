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
        let links: ShowLinks?
        
        enum CodingKeys: String, CodingKey {
            case id
            case url
            case name
            case type
            case language
            case genres
            case status
            case runtime
            case averageRuntime
            case premiered
            case ended
            case officialSite
            case schedule
            case rating
            case weight
            case network
            case externals
            case image
            case summary
            case updated
            case links = "_links"
        }
        
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
        
        public static func mockShow() -> Show {
            return Show(id: 1,
                        url: "https://www.tvmaze.com/shows/1/stranger-things",
                        name: "Stranger Things",
                        type: "Scripted",
                        language: "English",
                        genres: ["Drama", "Sci-Fi", "Thriller"],
                        status: "Ended",
                        runtime: 51,
                        averageRuntime: 51,
                        premiered: "2016-07-15",
                        ended: "2019-06-15",
                        officialSite: "https://www.hbo.com/stranger-things",
                        schedule: Schedule(time: "21:00", days: ["Thursday"]),
                        rating: ShowRating(average: 8.9),
                        weight: 95,
                        network: Network(id: 2, name: "HBO", country: ShowCountry(name: "United States", code: "US", timezone: "America/New_York"), officialSite: "https://www.hbo.com/"),
                        externals: Externals(tvrage: 236, thetvdb: 121361, imdb: "tt4574334"),  image: ShowImage(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/203824.jpg", original: "https://static.tvmaze.com/uploads/images/original_untouched/81/203824.jpg"),
                        summary: "When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.",
                        updated: 1616000000,
                        links: ShowLinks(linksSelf: SelfLinkShow(href: "https://api.tvmaze.com/shows/1"), previousepisode: PreviousEpisode(href: "https://api.tvmaze.com/episodes/185", name: "The Duff")))
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
    
    // MARK: - Links
    struct ShowLinks: Codable, Hashable {
        let linksSelf: SelfLinkShow
        let previousepisode: PreviousEpisode?
        
        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
            case previousepisode
        }
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
