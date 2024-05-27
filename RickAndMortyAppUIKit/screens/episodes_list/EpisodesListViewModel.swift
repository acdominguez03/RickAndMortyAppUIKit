//
//  EpisodesListViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation

class EpisodesListViewModel: ObservableObject {
    
    @Published var episodes: [EpisodeModel] = []
    @Published var loading: Bool = false
    
    var actualPage = 1
    
    let dataManager: EpisodesListDataManager
    
    init(dataManager: EpisodesListDataManager) {
        self.dataManager = dataManager
    }
    
    func getEpisodes(success: @escaping () -> Void) {
        self.loading = true
        dataManager.getEpisodes(
            page: actualPage,
            success: { episodes in
                self.episodes.append(contentsOf: episodes)
                self.loading = false
                success()
            }, failure: { error in
                print(error)
            }
        )
    }
    
    func updatePage() {
        actualPage = actualPage + 1
    }
}
