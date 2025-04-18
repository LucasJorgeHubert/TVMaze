//
//  Presenter.Show.Screens.ListShows.Components.ImageShow.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 18/04/25.
//

import SwiftUI

extension Presenter.Show.Screens.ListShows.Components {
    struct ImageShow: View {
        var show: Domain.Show.Model.Show
        
        var body: some View {
            AsyncImage(url: URL(string: "https://m.media-amazon.com/images/I/81arD48HpRL._AC_UF1000,1000_QL80_.jpg")!) { phase in
                if let img = phase.image {
                    img
                        .resizable()
                        .frame(maxWidth: 60, maxHeight: 100)
                        .aspectRatio(0.5, contentMode: .fit)
                        .clipShape(
                            RoundedRectangle(
                                cornerSize: CGSize(
                                    width: 8,
                                    height: 8)
                            )
                        )
                }
            }
        }
    }
}
