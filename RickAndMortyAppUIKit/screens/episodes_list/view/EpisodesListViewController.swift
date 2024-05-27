//
//  EpisodesListViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 24/5/24.
//

import UIKit
import Combine

class EpisodesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    private var viewModel: EpisodesListViewModel!
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Episodes"
        
        viewModel.getEpisodes(success: {
            self.collectionView.reloadData()
        })
        
        setUpCollectionView()

    }

    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: EpisodeCell.nibName, bundle: nil), forCellWithReuseIdentifier: EpisodeCell.identifier)
    }
    
    func set(viewModel: EpisodesListViewModel) {
        self.viewModel = viewModel
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
    
}

extension EpisodesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = viewModel.episodes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 10
        cell.lbName.text = element.name
        cell.lbEpisode.text = "Episode: " + element.episode
        cell.lbAirDate.text = "Air date: " + element.airDate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (viewModel.actualPage <= Constants.maxPageLocations && indexPath.row == viewModel.episodes.count - 1) {
            viewModel.updatePage()
            viewModel.getEpisodes {
                collectionView.reloadData()
            }
        }
    }
}

extension EpisodesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        return CGSize(width: self.view.frame.width - 20, height: 100)
    }
}

