//
//  ViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 20/5/24.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    let characters = [
        CharacterModel(name: "Fido", image: "fido", status: Status.Alive),
        CharacterModel(name: "Steve", image: "steve", status: Status.Dead),
        CharacterModel(name: "Gordon", image: "gordon", status: Status.Unknown)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(UINib(nibName: CharacterCell.nibName, bundle: nil), forCellWithReuseIdentifier: CharacterCell.identifier)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = characters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell

        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 25
        cell.ivCharacter.image = UIImage(named: element.image)
        cell.lbName.text = element.name
        cell.lbStatus.text = element.status.rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        return view
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let size = (collectionView.frame.width - 30)/2
        return CGSize(width: size, height: size)
    }
}


