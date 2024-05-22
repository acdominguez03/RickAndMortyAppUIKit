//
//  CharacterListWireframe.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import UIKit

class CharacterListWireframe {
    
    private var viewController: CharacterListViewController {
        let viewController: CharacterListViewController = CharacterListViewController(nibName: "CharacterListView", bundle: nil)
        let dataManager: CharacterListDataManager = createDataManager(apiClient: apiClient)
        let viewModel: CharacterListViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private var apiClient: ApiClient {
        return ApiClient()
    }
    
    private func createViewModel(with dataManager: CharacterListDataManager) -> CharacterListViewModel {
        return CharacterListViewModel(dataManager: dataManager)
    }
    
    private func createDataManager(apiClient: ApiClient) -> CharacterListDataManager {
        return CharacterListDataManager(apiClient: apiClient)
    }
    
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
