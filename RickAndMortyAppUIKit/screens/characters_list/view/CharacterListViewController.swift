//
//  CharacterListViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: CharacterListViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
        
        viewModel.getCharacters {
            self.collectionView.reloadData()
        }
        
        setUpCollectionView()
        
        responseViewModel()
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: CharacterCell.nibName, bundle: nil), forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    func responseViewModel() {
        viewModel.$loading.sink { isLoading in
            if(!isLoading) {
                self.loading.stopAnimating()
                self.collectionView.reloadData()
            } else {
                self.loading.startAnimating()
            }
        }.store(in: &cancellables)
    }
    
    func set(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
}

extension CharacterListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let elementId = viewModel.characters[indexPath.row].id
        DetailWireframe(characterId: elementId).push(navigation: navigationController)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = viewModel.characters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 25
        cell.ivCharacter.imageFrom(url: URL(string: element.image)!)
        cell.lbName.text = element.name
        cell.lbStatus.text = "Status: " + element.status
        
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (viewModel.actualPage < Constants.maxPageCharacters && indexPath.row == viewModel.characters.count - 1) {
            viewModel.updatePage()
            viewModel.getCharacters(success: {
                collectionView.reloadData()
            })
        }
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let size = (collectionView.frame.width - 30)/2
        return CGSize(width: size, height: 200)
    }
}


