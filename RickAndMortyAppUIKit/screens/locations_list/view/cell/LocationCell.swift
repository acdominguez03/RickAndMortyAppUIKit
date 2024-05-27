//
//  LocationsCell.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import UIKit

class LocationCell: UICollectionViewCell {

    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbDimension: UILabel!
    
    static let identifier = "LocationCellIdentifier"
    static let nibName = "LocationCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
