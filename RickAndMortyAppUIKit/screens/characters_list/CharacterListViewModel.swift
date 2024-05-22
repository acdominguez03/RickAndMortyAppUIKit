//
//  CharacterListViewModel.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import Foundation
import Alamofire

class CharacterListViewModel: ObservableObject {
    
    @Published var characters: [CharacterModel] = []
    @Published var loading: Bool = false
    
    var actualPage = 1
    
    let dataManager: CharacterListDataManager
    
    init(dataManager: CharacterListDataManager) {
        self.dataManager = dataManager
    }
    
    func getCharacters(success: @escaping () -> Void) {
        self.loading = true
        dataManager.getCharacters(
            page: actualPage,
            success: { characters in
                self.characters.append(contentsOf: characters)
                self.loading = false
            }, failure: { error in
                print(error)
            }
        )
    }
    
    func updatePage() {
        actualPage = actualPage + 1
    }
}
