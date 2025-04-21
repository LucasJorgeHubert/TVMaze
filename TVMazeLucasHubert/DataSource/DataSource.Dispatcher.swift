//
//  DataSource.Dispatcher.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

public protocol DispatcherProtocol {
    func request<T: Codable>(apiRouter: APIRouterProtocol) async throws -> T
}

extension DataSource {
    public class Dispatcher: DispatcherProtocol {
       
        private let session: URLSession
        private let maxRetries: Int
        
        public init(session: URLSession = .shared, maxRetries: Int = 3) {
            self.session = session
            self.maxRetries = maxRetries
        }
        
        public func request<T: Codable>(apiRouter: APIRouterProtocol) async throws -> T {
            var components = URLComponents()
            components.scheme = "https"
            components.host = DataSource.Environment.baseURL
            components.path = apiRouter.path
            
            if let queryItems = apiRouter.queryItems {
                components.queryItems = queryItems
            }
            
            guard let url = components.url else { throw TVMazeAPIRequestError.badUrl }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = apiRouter.method
            
            var currentAttempt = 0
            var lastError: Error?
            
            while currentAttempt < maxRetries {
                do {
                    let (data, response) = try await session.data(for: urlRequest)
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw TVMazeAPIRequestError.invalidResponse
                    }
                    
                    switch httpResponse.statusCode {
                        case 200...299:
                            return try JSONDecoder().decode(T.self, from: data)
                            
                        case 400...599:
                            let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data)
                            
                            if let apiError = apiError {
                                throw TVMazeAPIRequestError.apiError(apiError)
                            } else {
                                throw TVMazeAPIRequestError.unknownStatusCode(httpResponse.statusCode, nil)
                            }
                            
                        default:
                            throw TVMazeAPIRequestError.unknown
                    }
                    
                } catch {
                    lastError = error
                    currentAttempt += 1
                    print(error)
                    
                    if currentAttempt >= maxRetries {
                        throw lastError ?? TVMazeAPIRequestError.unknown
                    }
                    
                    try await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(currentAttempt)) * 500_000_000))
                }
            }
            
            throw TVMazeAPIRequestError.unknown
        }
        
    }
    
    public enum TVMazeAPIRequestError: Error {
        case badUrl
        case invalidResponse
        case apiError(APIErrorResponse)
        case unknownStatusCode(Int, APIErrorResponse?)
        case unknown
        
        var localizedDescription: String {
            switch self {
                case .badUrl:
                    return "URL inválida."
                case .invalidResponse:
                    return "Resposta inválida do servidor."
                case .apiError(let errorResponse):
                    return "Erro: \(errorResponse.message ?? "") (\(errorResponse.status ?? 0))"
                case .unknownStatusCode(let code, let errorResponse):
                    return "Erro \(code): \(errorResponse?.message ?? "Resposta desconhecida")"
                case .unknown:
                    return "Ocorreu um erro desconhecido."
            }
        }
    }
    
    public struct APIErrorResponse: Codable {
        let name: String?
        let message: String?
        let code: Int?
        let status: Int?
    }
}
