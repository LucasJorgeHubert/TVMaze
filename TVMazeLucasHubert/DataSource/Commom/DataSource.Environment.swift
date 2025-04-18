//
//  DataSource.Environment.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

extension DataSource {
    enum Environment {
        static var baseURL: String {
            guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
                fatalError("BASE_URL não configurada!")
            }
            return url
        }
    }

}
