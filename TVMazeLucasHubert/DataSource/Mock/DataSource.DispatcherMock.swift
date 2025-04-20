//
//  DataSource.Dispatcher.Mock.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension DataSource {
    public class DispatcherMock: DispatcherProtocol {
        public func request<T: Codable>(apiRouter: APIRouterProtocol) async throws -> T {
            
            guard let url = Bundle.main.url(forResource: resolveMockFileName(for: apiRouter), withExtension: "json") else { throw TVMazeAPIRequestError.badUrl }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        
        private func resolveMockFileName(for apiRouter: APIRouterProtocol) -> String {
            switch apiRouter {
                case is DataSource.Show.APIRouter:
                    return self.resolveShowAPIRouter(for: apiRouter)
                default:
                    return ""
            }
        }
        
        private func resolveShowAPIRouter(for apiRouter: APIRouterProtocol) -> String{
            if let router = apiRouter as? DataSource.Show.APIRouter {
                switch router {
                    case .getShows:
                        return "shows_page_1"
                    case .getShowsByName:
                        return "search"
                    case .getEpisodes:
                        return "episodes"
                    case .getCast:
                        return "cast"
                    case .getShowById:
                        return "Show"
                }
            }
            return ""
        }
    }
}
