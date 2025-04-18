//
//  Presenter.Show.Screens.ListShows.Components.ShowDetails.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI

extension Presenter.Show.Screens.ListShows.Components {
    struct ShowDetails: View {
        var show: Domain.Show.Model.Show
        
        var body: some View {
            VStack {
                if show.premiered != nil {
                    HStack {
                        Text("\(String(Calendar.current.component(.year, from: show.getDatePremiered())))")
                        
                        Text("-")
                        
                        Text("\(String(Calendar.current.component(.year, from: show.getDateEnded())))")
                    }
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                if let runtime = show.averageRuntime {
                    HStack{
                        Text("\(runtime) min")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if let network = show.network {
                    HStack {
                        Text("\(network.name)")
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
