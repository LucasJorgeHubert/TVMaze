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
        
        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
        static func from(_ item: Domain.Show.Model.Show) -> FavoriteItem {
            FavoriteItem(
                id: item.id,
                name: item.name
            )
        }
    }
}
