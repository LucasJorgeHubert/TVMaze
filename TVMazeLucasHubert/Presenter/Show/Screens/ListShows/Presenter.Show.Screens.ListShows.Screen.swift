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
    struct Screen: View {
        @ObservedObject var viewModel: Presenter.Show.Screens.ListShows.ViewModel
        @State var showSearch: Bool = false
        @Query var favorites: [Domain.Favorite.Model.FavoriteItem]
        
        var body: some View {
            NavigationStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.shows, id: \.id) { show in
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
    let container = try! ModelContainer(for: Domain.Favorite.Model.FavoriteItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = container.mainContext
    
    return PreviewWrapper {
        Presenter.Show.Screens.ListShows.Screen(
            viewModel: Presenter.Show.Screens.ListShows.DI().makeViewModel(context: context)
        )
    }
}


