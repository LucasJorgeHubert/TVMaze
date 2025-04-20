//
//  DataSource.Show.APIRouter.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension DataSource.Show {
    public enum APIRouter: APIRouterProtocol {
        case getShows(page: Int)
        case getShowsByName(search: String)
        case getShowById(id: Int)
        case getEpisodes(showId: Int)
        case getCast(showId: Int)
        
        public var path: String {
            switch self {
                case .getShows:
                    return "/shows"
                case .getShowsByName:
                    return "/search/shows"
                case .getEpisodes(let id):
                    return "/shows/\(id)/episodes"
                case .getCast(let id):
                    return "/shows/\(id)/cast"
                case .getShowById(let id):
                    return "/shows/\(id)"
            }
        }
        
        public var method: String {
            switch self {
                case .getShows, .getShowsByName, .getEpisodes, .getCast, .getShowById:
                    return "GET"
            }
        }
        
        public var queryItems: [URLQueryItem]? {
            switch self {
                case .getShows(let page):
                    return [URLQueryItem(name: "page", value: String(page))]
                case .getShowsByName(let search):
                    return [URLQueryItem(name: "q", value: search)]
                case .getEpisodes, .getCast, .getShowById:
                    return nil
            }
        }
    }
}
