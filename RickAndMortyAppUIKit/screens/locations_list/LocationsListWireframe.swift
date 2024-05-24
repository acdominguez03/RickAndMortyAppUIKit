//
//  LocationsListWireframe.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import Foundation
import UIKit

class LocationsListWireframe {
    private var viewController: LocationsListViewController {
        let viewController: LocationsListViewController = LocationsListViewController(nibName: "LocationsListView", bundle: nil)
        let dataManager: LocationsListDataManager = createDataManager(apiClient: apiClient)
        let viewModel: LocationsListViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private var apiClient: ApiClient {
        return ApiClient()
    }
    
    private func createViewModel(with dataManager: LocationsListDataManager) -> LocationsListViewModel {
        return LocationsListViewModel(dataManager: dataManager)
    }
    
    private func createDataManager(apiClient: ApiClient) -> LocationsListDataManager {
        return LocationsListDataManager(apiClient: apiClient)
    }
    
    func getViewController() -> LocationsListViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
