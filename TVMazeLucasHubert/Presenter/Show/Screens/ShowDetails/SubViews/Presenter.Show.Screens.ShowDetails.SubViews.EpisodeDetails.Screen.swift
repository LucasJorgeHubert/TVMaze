//
//  Presenter.Show.Screens.ShowDetails.SubViews.EpisodeDetails.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation
import SwiftUI

extension Presenter.Show.Screens.ShowDetails.SubViews.EpisodeDetails {
    struct Screen: View {
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
