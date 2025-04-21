//
//  Presenter.Show.Screens.ListShows.ViewModel.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

extension Presenter.Show.Screens.ListShows {
    class ViewModel: ObservableObject {
        @Published var shows: [Domain.Show.Model.Show] = []
        @Published var mock: [String] = ["a", "b", "c"]
        @Published var isLoading: Bool = false
        @Published var searchTerm: String = ""
        @Published var pageNumber: Int = 1
        
        var wasSearched = false
        
        let getShowUseCase: Domain.Show.UseCase.GetShows
        let getShowBySearchUseCase: Domain.Show.UseCase.GetShowByName
        
        private var searchCancellable: Set<AnyCancellable> = []
        
        init(
            getShowUseCase: Domain.Show.UseCase.GetShows,
            getShowBySearchUseCase: Domain.Show.UseCase.GetShowByName
        ) {
            self.getShowUseCase = getShowUseCase
            self.getShowBySearchUseCase = getShowBySearchUseCase
            
            setupSearchDebounce()
        }
        
        private func setupSearchDebounce() {
            $searchTerm
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .removeDuplicates()
                .sink { [weak self] term in
                    guard let self = self else { return }
                    
                    if term.isEmpty && self.wasSearched {
                        Task {
                            self.isLoading = true
                            do {
                                self.shows = []
                                self.pageNumber = 1
                                try await self.getShows()
                            } catch {
                                print(error)
                            }
                        }
                        return
                    }
                    if term.isEmpty {
                        return
                    }
                    Task {
                        self.isLoading = true
                        do {
                            try await self.getShowsBySearch(term: term)
                            self.wasSearched = true
                        } catch {
                            print(error)
                        }
                    }
                }
                .store(in: &searchCancellable)
        }
        
        @MainActor
        func getShows() async throws {
            isLoading = true
            shows += try await getShowUseCase.execute(page: pageNumber)
            isLoading = false
        }
        
        @MainActor
        func getShowsBySearch(term: String) async throws {
            isLoading = true
            let filtered = try await getShowBySearchUseCase.execute(search: term)
            shows = filtered
            isLoading = false
        }
        
        func colorForGenre(_ genre: String) -> Color {
            switch genre {
                case "Action": return .red.opacity(0.5)
                case "Adventure": return .blue.opacity(0.5)
                case "Animation": return .green.opacity(0.5)
                case "Comedy": return .yellow.opacity(0.5)
                case "Crime": return .orange.opacity(0.5)
                case "Drama": return .purple.opacity(0.5)
                case "Fantasy": return .indigo.opacity(0.5)
                case "Horror": return .pink.opacity(0.5)
                case "Mystery": return .teal.opacity(0.5)
                default: return .gray.opacity(0.5)
            }
        }
        
        func addToFavorite(_ show: Domain.Show.Model.Show, context: ModelContext) throws {
            let favorite = Domain.Favorite.Model.FavoriteItem.from(show)
            context.insert(favorite)
            try context.save()
        }
        
        func removeFromFavorite(_ show: Domain.Show.Model.Show, context: ModelContext) throws {
            let descriptor = FetchDescriptor<Domain.Favorite.Model.FavoriteItem>(predicate: #Predicate { $0.id == show.id })
            if let favorite = try? context.fetch(descriptor).first {
                context.delete(favorite)
                try? context.save()
            }
        }
        
        func isFavorite(_ show: Domain.Show.Model.Show, favorites: [Domain.Favorite.Model.FavoriteItem]) -> Bool {
            return favorites.contains { $0.id == show.id }
        }
    }
}
