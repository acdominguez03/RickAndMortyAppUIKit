//
//  EpisodeCell.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
   
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbEpisode: UILabel!
    @IBOutlet weak var lbAirDate: UILabel!
    
    static let identifier = "EpisodeCellIdentifier"
    static let nibName = "EpisodeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
