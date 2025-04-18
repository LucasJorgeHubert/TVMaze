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
        
        public var path: String {
            switch self {
            case .getShows:
                return "/shows"
            case .getShowsByName:
                return "/search/shows"
            }
        }
        
        public var method: String {
            switch self {
            case .getShows:
                return "GET"
            case .getShowsByName:
                return "GET"
            }
        }
        
        public var queryItems: [URLQueryItem]? {
            switch self {
            case .getShows(let page):
                return [URLQueryItem(name: "page", value: String(page))]
            case .getShowsByName(let search):
                return [URLQueryItem(name: "q", value: search)]
            }
        }
    }
}
