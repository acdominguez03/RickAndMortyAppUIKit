//
//  LocationsListViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import UIKit

class LocationsListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: LocationsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"

    }
    
    func set(viewModel: LocationsListViewModel) {
        self.viewModel = viewModel
    }

}
