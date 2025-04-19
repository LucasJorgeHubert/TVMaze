//
//  Presenter.Show.Screens.ShowDetail.Screen.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI
import SwiftData

extension Presenter.Show.Screens.ShowDetails {

    struct ScreenWrapper: View {
        @EnvironmentObject var injector: Presenter.Show.DependencyInjector
        let show: Domain.Show.Model.Show
        
        var body: some View {
            Screen(viewModel: .init(
                        show: show,
                        getEpisodesUseCase: injector.getEpisodesUseCase,
                        getCastUseCase: injector.getCastUseCase,
                        context: injector.context
                    )
           )
        }
    }
    
    
    struct Screen: View {
        @StateObject var viewModel: Presenter.Show.Screens.ShowDetails.ViewModel
        
        var body: some View {
            NavigationStack {
                if viewModel.loading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            AsyncImage(
                                url: URL(string: "https://s2-techtudo.glbimg.com/OGy6-3LPveWyyZMQJ-n2_uS7suc=/0x0:1024x576/924x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2023/7/q/v3oenfSgGOlM9YwDudnw/stranger-things-netflix-techtudo.jpg")!
                            ) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                            
                            Presenter.Helpers.HTMLTextView.makeText(html: viewModel.show.summary)
                                .padding(.horizontal)
                            
                            List {
                                ForEach(viewModel.episodes.keys.sorted(), id: \.self) { season in
                                    Section(header: Text("Season \(season)")) {
                                        ForEach(viewModel.episodes[season]!, id: \.id) { episode in
                                            Text(episode.name)
                                        }
                                    }
                                }
                            }
                            .listStyle(.insetGrouped)
                            
                        }
                        .padding(.top)
                    }
                    .navigationTitle(viewModel.show.name)
                }
            }
            .onAppear() {
                Task {
                    do {
                        try await viewModel.getEpisodes()
                        try await viewModel.getCast()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    return PreviewWrapper {
        Presenter.Show.Screens.ShowDetails.ScreenWrapper(show: Domain.Show.Model.Show.mockShow())
        
    }
}
