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
        @State private var selectedShow: Domain.Show.Model.Show? = nil
        @State private var isDetailViewPresented: Bool = false
        @State private var isCreatedPinPresented: Bool = false
        @State private var showConfirmation = false
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.shows, id: \.id) { show in
                            GroupBox {
                                HStack {
                                    Presenter.Show.Screens.ListShows.Components.ImageShow(show: show)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(show.name)
                                            .font(.title2)
                                        
                                        Presenter.Show.Screens.ListShows.Components.Genres(viewModel: viewModel, show: show)
                                            .padding(.bottom, 4)
                                        
                                        Presenter.Show.Screens.ListShows.Components.ShowDetails(show: show)
                                    }
                                    
                                    Presenter.Show.Screens.ListShows.Components.FavoriteAndRating(viewModel: viewModel, show: show)
                                }
                                .padding(.vertical, 4)
                            }
                            .onAppear() {
                                if show.id == viewModel.shows.last?.id {
                                    Task {
                                        do {
                                            viewModel.pageNumber += 1
                                            try await viewModel.getShows()
                                        } catch {
                                            print("error: \(error)")
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                selectedShow = show
                                isDetailViewPresented = true
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
                .searchable(text: $viewModel.searchTerm, isPresented: $showSearch, placement: .navigationBarDrawer, prompt: "Search Show")
                .searchPresentationToolbarBehavior(.avoidHidingContent)
                .navigationTitle("Shows")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem {
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    ToolbarItem {
                        Button {
                            if KeychainService.shared.hasSavedPIN() {
                                showConfirmation = true
                            } else {
                                isCreatedPinPresented = true
                            }
                        } label: {
                            Image(systemName: "key")
                                .tint(KeychainService.shared.hasSavedPIN() ? .green : .red)
                        }
                    }
                    ToolbarItem {
                        Button {
                            showSearch.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
                .alert("Are you sure you want to remove your PIN?", isPresented: $showConfirmation) {
                    Button("Remove", role: .destructive) {
                        KeychainService.shared.deletePIN()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .navigationDestination(isPresented: $isDetailViewPresented) {
                    if let show = selectedShow {
                        Presenter.Show.Screens.ShowDetails.Screen(viewModel: Presenter.Show.Screens.ShowDetails.Factory.makeViewModel(show: show))
                    }
                }
                .navigationDestination(isPresented: $isCreatedPinPresented) {
                    Presenter.Pin.Create.Screen()
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
        Presenter.Show.Screens.ListShows.Screen(viewModel: Presenter.Show.Screens.ListShows.Factory.makeViewModel())
    }
}
