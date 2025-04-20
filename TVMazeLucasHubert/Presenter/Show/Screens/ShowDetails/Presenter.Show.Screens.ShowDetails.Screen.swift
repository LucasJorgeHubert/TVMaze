//
//  Presenter.Show.Screens.ShowDetails.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 19/04/25.
//

import SwiftUI

extension Presenter.Show.Screens.ShowDetails {
    struct Screen: View {
        @ObservedObject var viewModel: ViewModel
        @State var showSheet: Bool = false
        
        var body: some View {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: viewModel.show.image.medium)) { phase in
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
                        
                        GroupBox(label: Label("Summary", systemImage: "info.circle")) {
                            Presenter.Helpers.HTMLTextView.makeText(html: viewModel.show.summary)
                                .padding(.top, 8)
                        }
                        
                        Text("Release Year: \(String(Calendar.current.component(.year, from: viewModel.show.getDatePremiered())))")
                            .font(.subheadline)
                            .padding(.vertical)
                        
                        if viewModel.show.ended != nil {
                            Text("Ended: \(String(Calendar.current.component(.year, from: viewModel.show.getDateEnded())))")
                                .font(.subheadline)
                        }
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 8) {
                                ForEach(viewModel.show.genres, id: \.self) { genre in
                                    GroupBox {
                                        Text(genre)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        GroupBox {
                            Text("Episodes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onTapGesture {
                            showSheet.toggle()
                        }
                        
                        
                        
                    }
                    .padding()
                }
                .sheet(isPresented: $showSheet) {
                    ListEpisodes(episodes: viewModel.episodes)
                }
                .navigationTitle(viewModel.show.name)
                .navigationBarTitleDisplayMode(.large)
                .toolbar(.hidden, for: .tabBar)
            }
        }
    }
    
    struct ListEpisodes: View {
        @State var isExpanded: Set<Int> = [1]
        var episodes: [Int : [Domain.Show.Model.Episode]]
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            NavigationStack {
                VStack {
                    List {
                        ForEach(episodes.keys.sorted(), id: \.self) { season in
                            Section(isExpanded: Binding<Bool>(
                                get: {
                                    isExpanded.contains(season)
                                },
                                set: { newValue in
                                    if newValue {
                                        isExpanded.insert(season)
                                    } else {
                                        isExpanded.remove(season)
                                    }
                                }
                            )) {
                                ForEach(episodes[season] ?? [], id: \.self) { episode in
                                    NavigationLink {
                                        EpisodeDetails(episode: episode)
                                    } label: {
                                        Text("\(episode.number) - \(episode.name)")
                                    }
                                }
                            } header: {
                                Text("Season \(season)")
                            }
                            
                        }
                    }
                    .listStyle(.sidebar)
                }
                .navigationTitle("Episodes")
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
            }
        }
    }
    
    struct EpisodeDetails: View {
        var episode: Domain.Show.Model.Episode
        
        var body: some View {
            NavigationStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: episode.image.medium)) { phase in
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Episode: \(episode.number)")
                                .font(.headline)
                            
                            Text("Season: \(episode.season)")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let airdate = episode.getAirdate() {
                            Text("Air date: \(String(Calendar.current.component(.month, from: airdate)))/\(String(Calendar.current.component(.year, from: airdate)))")
                                .font(.subheadline)
                        }
                        
                        Text("Summary")
                            .font(.headline)
                        
                        Presenter.Helpers.HTMLTextView.makeText(html: episode.summary)
                    }
                }
                .padding()
                .navigationTitle(episode.name)
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}



                    


