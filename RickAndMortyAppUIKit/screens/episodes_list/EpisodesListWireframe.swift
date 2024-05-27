//
//  EpisodesListWireframe.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation
import UIKit

class EpisodesListWireframe {
    
    private var viewController: EpisodesListViewController {
        let viewController: EpisodesListViewController = EpisodesListViewController(nibName: "EpisodesListView", bundle: nil)
        let dataManager: EpisodesListDataManager = createDataManager(apiClient: apiClient)
        let viewModel: EpisodesListViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private var apiClient: ApiClient {
        return ApiClient()
    }
    
    private func createViewModel(with dataManager: EpisodesListDataManager) -> EpisodesListViewModel {
        return EpisodesListViewModel(dataManager: dataManager)
    }
    
    private func createDataManager(apiClient: ApiClient) -> EpisodesListDataManager {
        return EpisodesListDataManager(apiClient: apiClient)
    }
    
    func getViewController() -> EpisodesListViewController {
        return viewController
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
    
}
