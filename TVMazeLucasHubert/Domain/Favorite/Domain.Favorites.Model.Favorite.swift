//
//  Domain.Favorites.Model.Favorite.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation
import SwiftData

extension Domain.Favorite.Model {
    
    @Model
    final class FavoriteItem {
        @Attribute(.unique) var id: Int
        var name: String
        var type: String
        var language: String
        var genres: [String]
        var status: String
        var runtime: Int
        var averageRuntime: Int
        var premiered: String
        var ended: String
        var officialSite: String
        var image: Domain.Show.Model.ShowImage
        var summary: String
        var updated: Int
        
        init(id: Int, name: String, type: String, language: String, genres: [String], status: String, runtime: Int, averageRuntime: Int, premiered: String, ended: String, officialSite: String, image: Domain.Show.Model.ShowImage, summary: String, updated: Int) {
            self.id = id
            self.name = name
            self.type = type
            self.language = language
            self.genres = genres
            self.status = status
            self.runtime = runtime
            self.averageRuntime = averageRuntime
            self.premiered = premiered
            self.ended = ended
            self.officialSite = officialSite
            self.image = image
            self.summary = summary
            self.updated = updated
        }
        
        static func from(_ item: Domain.Show.Model.Show) -> FavoriteItem {
            FavoriteItem(
                id: item.id,
                name: item.name,
                type: item.type,
                language: item.language,
                genres: item.genres,
                status: item.status,
                runtime: item.runtime ?? 0,
                averageRuntime: item.averageRuntime ?? 0,
                premiered: item.premiered ?? "",
                ended: item.ended ?? "",
                officialSite: item.officialSite ?? "",
                image: item.image,
                summary: item.summary,
                updated: item.updated
            )
        }
    }
}
