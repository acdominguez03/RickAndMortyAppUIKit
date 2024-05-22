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
    
    let dataManager: CharacterListDataManager
    
    init(dataManager: CharacterListDataManager) {
        self.dataManager = dataManager
    }
    
    func getCharacters() {
        self.loading = true
        dataManager.getCharacters(success: { characters in
            self.characters = characters
            self.loading = false
        }, failure: { error in
            print(error)
        })
    }
}
