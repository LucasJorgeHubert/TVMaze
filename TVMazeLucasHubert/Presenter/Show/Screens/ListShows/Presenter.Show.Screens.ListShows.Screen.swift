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
                        Button {
                            //
                        } label: {
                            
                            Image(systemName: "slider.horizontal.3")
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
                .navigationDestination(isPresented: $isDetailViewPresented) {
                    if let show = selectedShow {
                        Presenter.Show.Screens.ListShows.TVShowDetailView(tvShow: show)
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
    
    
    
    struct TVShowDetailView: View {
        let tvShow: Domain.Show.Model.Show
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    Group {
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: tvShow.image.original)) { phase in
                                switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .cornerRadius(8)
                                    case .failure:
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                }
                            }
                            
                            Text("Description")
                                .font(.headline)
                            
                            Presenter.Helpers.HTMLTextView.makeText(html: tvShow.summary)
                            
                            if let genre = tvShow.genres.first {
                                Text("Genre: \(genre)")
                                    .font(.subheadline)
                            }
                            Text("Release Year: \(String(Calendar.current.component(.year, from: tvShow.getDatePremiered())))")
                                .font(.subheadline)
                            
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
                .navigationTitle(tvShow.name)
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

#Preview {
    return PreviewWrapper {
        Presenter.Show.Screens.ListShows.Screen(viewModel: Presenter.Show.Screens.ListShows.Factory.makeViewModel())
    }
}


