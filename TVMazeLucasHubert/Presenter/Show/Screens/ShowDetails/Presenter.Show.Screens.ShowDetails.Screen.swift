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
        @State var isExpanded: Set<Int> = []
        var body: some View {
            NavigationStack {
                VStack {
                    List {
                        ForEach(viewModel.episodes.keys.sorted(), id: \.self) { season in
                            Section {
                                ForEach(viewModel.episodes[season] ?? [], id: \.self) { episode in
                                    Text("\(episode.name)")
                                }
                            } header: {
                                Text("season \(season)")
                            }


                        }
                        .listStyle(.sidebar)
                    }
                }
                
                .navigationTitle(viewModel.show.name)
                .navigationBarTitleDisplayMode(.large)
                .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}



    //                ScrollView {
    //                    VStack(alignment: .leading) {
    //                        AsyncImage(url: URL(string: viewModel.show.image.original)) { phase in
    //                            switch phase {
    //                                case .empty:
    //                                    ProgressView()
    //                                case .success(let image):
    //                                    image
    //                                        .resizable()
    //                                        .scaledToFit()
    //                                        .frame(maxWidth: .infinity)
    //                                        .cornerRadius(8)
    //                                case .failure:
    //                                    Image(systemName: "photo.fill")
    //                                        .resizable()
    //                                        .scaledToFit()
    //                                        .frame(maxWidth: .infinity)
    //                                        .foregroundColor(.gray)
    //                                @unknown default:
    //                                    EmptyView()
    //                            }
    //                        }
    //
    //                        Text("Description")
    //                            .font(.headline)
    //
    //                        Presenter.Helpers.HTMLTextView.makeText(html: viewModel.show.summary)
    //
    //                        if let genre = viewModel.show.genres.first {
    //                            Text("Genre: \(genre)")
    //                                .font(.subheadline)
    //                        }
    //                        Text("Release Year: \(String(Calendar.current.component(.year, from: viewModel.show.getDatePremiered())))")
    //                            .font(.subheadline)
    //
    //
    //                        LazyVStack(alignment: .leading) {
    //                            ForEach(viewModel.episodes.keys.sorted(), id: \.self) { season in
    //                                GroupBox(label: Text("Season \(season)")) {
    //                                    ForEach(viewModel.episodes[season] ?? []) { episode in
    //                                        VStack(alignment: .leading, spacing: 4) {
    //                                            GroupBox {
    //                                                Text("EP \(episode.number) - \(episode.name)")
    //                                                    .font(.body)
    //                                                    .frame(maxWidth: .infinity, alignment: .leading)
    //                                            }
    //                                        }
    //                                        .padding(.vertical, 4)
    //                                    }
    //                                }
    //
    //                            }
    //                        }
    //
    //                        Spacer()
    //                    }
    //                    .padding()
    //                }
