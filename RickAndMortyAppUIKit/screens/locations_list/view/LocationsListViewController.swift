//
//  LocationsListViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import Combine
import UIKit

class LocationsListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: LocationsListViewModel!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Locations"
        
        viewModel.getLocations {
            self.collectionView.reloadData()
        }
        
        setUpCollectionView()
        
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: LocationCell.nibName, bundle: nil), forCellWithReuseIdentifier: LocationCell.identifier)
    }
    
    func set(viewModel: LocationsListViewModel) {
        self.viewModel = viewModel
    }
    
    func responseViewModel() {
        viewModel.$locations.sink { locations in
            print(locations)
        }.store(in: &cancellables)
    }
}

extension LocationsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.locations.count)
        return viewModel.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = viewModel.locations[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.identifier, for: indexPath) as! LocationCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 10
        cell.lbName.text = element.name
        cell.lbType.text = "Type: " + element.type
        cell.lbDimension.text = "Dimension: " + element.dimension
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (viewModel.actualPage <= Constants.maxPageLocations && indexPath.row == viewModel.locations.count - 1) {
            viewModel.updatePage()
            viewModel.getLocations {
                collectionView.reloadData()
            }
        }
    }
}

extension LocationsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: self.view.frame.width - 20, height: 100)
    }
}
