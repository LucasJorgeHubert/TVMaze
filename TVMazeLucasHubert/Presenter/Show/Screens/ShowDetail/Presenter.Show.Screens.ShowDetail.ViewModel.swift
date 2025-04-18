//
//  Presenter.Show.Screens.ShowDetail.ViewModel.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import Foundation

extension Presenter.Show.Screens.ShowDetails {
    class ViewModel: ObservableObject {
        @Published var show: Domain.Show.Model.Show?
        
        let context: ModelContext
        
        init(show: Domain.Show.Model.Show, context: ModelContext) {
            self.show = show
            self.context = context
        }
    }
}
