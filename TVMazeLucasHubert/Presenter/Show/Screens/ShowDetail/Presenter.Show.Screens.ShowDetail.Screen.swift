//
//  Presenter.Show.Screens.ShowDetail.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI
import SwiftData

extension Presenter.Show.Screens.ShowDetails {
    struct Screen: View {
        @ObservedObject var viewModel: ViewModel
    
        var body: some View {
            NavigationStack {
                ScrollView {
                    
                }
                .navigationTitle(viewModel.show.name)
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Domain.Favorite.Model.FavoriteItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    let show = Domain.Show.Model.Show.mockShow()
    
    return PreviewWrapper {
        Presenter.Show.Screens.ShowDetails.Screen(viewModel: Presenter.Show.Screens.ShowDetails.DI().makeViewModel(context: context, show:show)
        )
    }
}
