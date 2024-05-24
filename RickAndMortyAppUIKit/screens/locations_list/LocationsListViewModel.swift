//
//  LocationsListViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import Foundation

class LocationsListViewModel: ObservableObject {
    
    let dataManager: LocationsListDataManager
    
    init(dataManager: LocationsListDataManager) {
        self.dataManager = dataManager
    }
    
}
