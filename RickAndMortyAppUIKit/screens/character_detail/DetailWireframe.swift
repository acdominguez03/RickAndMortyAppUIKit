//
//  DetailWireframe.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import UIKit

class DetailWireframe {
    
    let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    private var viewController: DetailViewController {
        let viewController: DetailViewController = DetailViewController(nibName: "DetailView", bundle: nil)
        let dataManager: DetailDataManager = createDataManager(apiClient: apiClient)
        let viewModel: DetailViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private var apiClient: ApiClient {
        return ApiClient()
    }
    
    private func createViewModel(with dataManager: DetailDataManager) -> DetailViewModel {
        return DetailViewModel(dataManager: dataManager, characterId: characterId)
    }
    
    private func createDataManager(apiClient: ApiClient) -> DetailDataManager {
        return DetailDataManager(apiClient: apiClient)
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
    
}
