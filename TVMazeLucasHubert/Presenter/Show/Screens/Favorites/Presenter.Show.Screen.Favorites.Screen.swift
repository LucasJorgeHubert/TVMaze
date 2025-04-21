//
//  Presenter.Show.Screen.Favorites.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI
import SwiftData

extension Presenter.Show.Screens.Favorites {
    struct Screen: View {
        @Environment(\.modelContext) private var context
        @Query(sort: \Domain.Favorite.Model.FavoriteItem.name, order: .forward) var favorites: [Domain.Favorite.Model.FavoriteItem]
        @ObservedObject var viewModel: Presenter.Show.Screens.Favorites.ViewModel
        @State private var isPresentingDetails: Bool = false
        @State private var selectedFavoriteID: Int?
        @State private var showDetailsViewModel: Presenter.Show.Screens.ShowDetails.ViewModel?
        @State private var isLoading: Bool = false

        var body: some View {
            NavigationStack{
                VStack {
                    if favorites.isEmpty {
                        Text("No favorites yet")
                    } else {
                        List{
                            ForEach(favorites, id: \.id) { favorite in
                                Button {
                                    guard !isLoading else { return }
                                    
                                    selectedFavoriteID = favorite.id
                                    isLoading = true
                                    Task {
                                        do {
                                            let show = try await viewModel.getShow(id: favorite.id)
                                            showDetailsViewModel = Presenter.Show.Screens.ShowDetails.Factory.makeViewModel(show: show)
                                            isPresentingDetails = true
                                        } catch {
                                            print(error)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(favorite.name)
                                        
                                        if isLoading && selectedFavoriteID == favorite.id {
                                            ProgressView()
                                        }
                                    }
                                }
                                .disabled(isLoading && selectedFavoriteID != favorite.id)
                                .listRowBackground(isLoading && selectedFavoriteID == favorite.id ? Color.gray.opacity(0.3) : nil)
                                .swipeActions() {
                                    Button(role: .destructive) {
                                        Task {
                                            do {
                                                context.delete(favorite)
                                                try context.save()
                                            } catch {
                                                print(error)
                                            }
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Favorites")
                .navigationDestination(isPresented: $isPresentingDetails) {
                    if let showDetailsViewModel = showDetailsViewModel {
                        Presenter.Show.Screens.ShowDetails.Screen(viewModel: showDetailsViewModel)
                            .onDisappear {
                                isLoading = false
                                selectedFavoriteID = nil
                            }
                    }
                }
            }
        }
    }
}
