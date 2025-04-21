//
//  Domain.Show.Model.Cast.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension Domain.Show.Model {
    public struct Cast: Codable, Hashable, Identifiable {
        public let id = UUID()
        public let person: Person?
    }
    
    public struct Person: Codable, Hashable {
        public let id: Int
        public let name: String
        public let image: CastImage?
    }
    
    public struct CastImage: Codable, Hashable {
        public let medium: String
        public let original: String
    }
}
