//
//  DetailViewController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 22/5/24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    let id: Int = 1
    
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbSpecie: UILabel!
    @IBOutlet weak var lbOrigin: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    
    private var viewModel: DetailViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImage()
        responseViewModel()
        viewModel.getCharacter(id: viewModel.characterId)
        
    }
    
    func setUpImage() {
        ivCharacter.layer.cornerRadius = ivCharacter.frame.width / 2
        ivCharacter.clipsToBounds = true
    }

    func responseViewModel() {
        viewModel.$character.compactMap({$0}).sink { [weak self] value in
            self?.ivCharacter.imageFrom(url: URL(string: value.image)!)
            self?.lbName.text = value.name
            self?.lbStatus.text = "Status: " + value.status
            if(value.type.isEmpty) {
                self?.lbType.text = "Type of character: Unknown"
            } else {
                self?.lbType.text = "Type of character: " + value.type
            }
            self?.lbSpecie.text = "Specie: " + value.species
            self?.lbOrigin.text = "Origin: " + value.origin
            self?.lbLocation.text = "Actual location: " + value.location
        }.store(in: &cancellables)
    }
    
    func set(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
}
