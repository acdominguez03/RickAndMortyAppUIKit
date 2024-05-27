//
//  LocationsListDataManager.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import Foundation

class LocationsListDataManager {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getLocations(
        page: Int,
        success: @escaping ([LocationModel]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        let parameters = ["page": page]
        
        apiClient.locationsRequest(
            parameters: parameters,
            success: { locationsDTO in
                let locations = locationsDTO.results.map { locationDTO in
                    locationDTO.toLocationModel()
                }
                success(locations)
            }, failure: { error in
                failure(error)
            }
        )
    }
}
