//
//  LocationsListViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import Foundation

class LocationsListViewModel: ObservableObject {
    
    @Published var locations: [LocationModel] = []
    
    var actualPage = 1
    
    let dataManager: LocationsListDataManager
    
    init(dataManager: LocationsListDataManager) {
        self.dataManager = dataManager
    }
    
    func getLocations(success: @escaping () -> Void) {
        dataManager.getLocations(
            page: actualPage,
            success: { locations in
                self.locations.append(contentsOf: locations)
                print(locations)
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
