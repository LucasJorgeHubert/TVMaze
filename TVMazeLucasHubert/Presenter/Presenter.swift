//
//  Presenter.swift
//  TVMazeLucasHubert
//
//  Created by Lucas Hubert on 17/04/25.
//

import Foundation

public enum Presenter {
    public enum Show {
        public enum TabBar { }
        public enum Screens {
            public enum ListShows { 
                public enum Components { }
            }
            public enum Favorites { }
            public enum ShowDetails {
                public enum SubViews {
                    public enum ListEpisodes { }
                    public enum EpisodeDetails { }
                }
            }
        }
    }
    public enum Pin {
        public enum Create { }
        public enum Login { }
    }
    public enum Helpers { }
}
