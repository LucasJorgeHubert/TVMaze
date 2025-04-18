//
//  DataSource.Protocol.APIRouter.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

public protocol APIRouterProtocol {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
}
