//
//  Presenter.Show.Screens.ShowDetails.SubViews.Listepisodes.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 20/04/25.
//

import Foundation
import SwiftUI

extension Presenter.Show.Screens.ShowDetails.SubViews.ListEpisodes {
    struct Screen: View {
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
                                        Presenter.Show.Screens.ShowDetails.SubViews.EpisodeDetails.Screen(episode: episode)
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
}
