//
//  EpisodesListDataManager.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation
class EpisodesListDataManager {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getEpisodes(
        page: Int,
        success: @escaping ([EpisodeModel]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let parameters = ["page": page]
        
        apiClient.episodesRequest(
            parameters: parameters,
            success: { episodesListDTO in
                let episodes = episodesListDTO.results.map { episode in
                    episode.toEpisodeModel()
                }
                success(episodes)
            }, failure: { error in
                failure(error)
            }
        )
    }
}
