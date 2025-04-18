//
//  Domain.Show.Model.Cast.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension Domain.Show.Model {
    public struct Cast: Codable, Hashable {
        public let person: Person
        public let character: CastCharacter
        public let voice: Bool
        public let self_: Bool
        
        enum CodingKeys: String, CodingKey {
            case person
            case character
            case voice
            case self_ = "self"
        }
    }
    
    public struct Person: Codable, Hashable {
        public let id: Int
        public let url: String
        public let name: String
        public let country: Country
        public let birthday: String
        public let deathday: String?
        public let gender: String
        public let image: CastImage
        public let updated: Int
        public let _links: LinksCast
    }
    
    public struct LinksCast : Codable, Hashable {
        public let self_: LinkRef
        
        enum CodingKeys: String, CodingKey {
            case self_ = "self"
        }
    }
    
    public struct LinkRef: Codable, Hashable {
        public let href: String
    }
    
    public struct CastImage: Codable, Hashable {
        public let medium: String
        public let original: String
    }
    
    public struct CastCharacter: Codable, Hashable {
        public let id: Int
        public let url: String
        public let name: String
        public let image: CastImage
        public let _links: Links
    }
    
    public struct Country: Codable, Hashable {
        public let name: String
        public let code: String
        public let timezone: String
    }
    
    /*
     "person": {
     "id": 1,
     "url": "https://www.tvmaze.com/people/1/mike-vogel",
     "name": "Mike Vogel",
     "country": {
     "name": "United States",
     "code": "US",
     "timezone": "America/New_York"
     },
     "birthday": "1979-07-17",
     "deathday": null,
     "gender": "Male",
     "image": {
     "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/0/1815.jpg",
     "original": "https://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg"
     },
     "updated": 1732284645,
     "_links": {
     "self": {
     "href": "https://api.tvmaze.com/people/1"
     }
     }
     },
     "character": {
     "id": 1,
     "url": "https://www.tvmaze.com/characters/1/under-the-dome-dale-barbie-barbara",
     "name": "Dale "Barbie" Barbara",
     "image": {
     "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/0/3.jpg",
     "original": "https://static.tvmaze.com/uploads/images/original_untouched/0/3.jpg"
     },
     "_links": {
     "self": {
     "href": "https://api.tvmaze.com/characters/1"
     }
     }
     },
     "self": false,
     "voice": false*/
}
