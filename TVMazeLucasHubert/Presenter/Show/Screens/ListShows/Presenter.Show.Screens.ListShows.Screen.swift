//
//  Presenter.Show.Screens.ListShows.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import SwiftUI
import Combine
import SwiftData

extension Presenter.Show.Screens.ListShows {
    
    struct ScreenWrapper: View {
        @EnvironmentObject var injector: Presenter.Show.DependencyInjector
        
        var body: some View {
            Screen(viewModel:
                    .init(
                        getShowUseCase: injector.getShowUseCase,
                        getShowBySearchUseCase: injector.getShowBySearchUseCase,
                        context: injector.context
                    )
            )
        }
    }
    
    struct Screen: View {
        @StateObject var viewModel: Presenter.Show.Screens.ListShows.ViewModel
        @State var showSearch: Bool = false
        @Query var favorites: [Domain.Favorite.Model.FavoriteItem]
        
        var body: some View {
            NavigationStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.shows, id: \.id) { show in
                        NavigationLink(
                            destination: Presenter.Show.Screens.ShowDetails.ScreenWrapper(show: show)) {
                            HStack {
                                Presenter.Show.Screens.ListShows.Components.ImageShow(show: show)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(show.name)
                                        .font(.title2)
                                    
                                    Presenter.Show.Screens.ListShows.Components.Genres(viewModel: viewModel, show: show)
                                    
                                    Spacer()
                                    
                                    Presenter.Show.Screens.ListShows.Components.ShowDetails(show: show)
                                }
                                
                                Presenter.Show.Screens.ListShows.Components.FavoriteAndRating(viewModel: viewModel, show: show)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchTerm, isPresented: $showSearch, placement: .navigationBarDrawer, prompt: "Search Show")
                    .searchPresentationToolbarBehavior(.avoidHidingContent)
                    .navigationTitle("Shows")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        ToolbarItem {
                            Button {
                                showSearch.toggle()
                            } label: {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                    }
                }
            }
            .onAppear() {
                Task {
                    do {
                        try await viewModel.getShows()
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    return PreviewWrapper {
        Presenter.Show.Screens.ListShows.ScreenWrapper()
    }
}


