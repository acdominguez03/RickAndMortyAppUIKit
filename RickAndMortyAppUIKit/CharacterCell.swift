//
//  CharacterCell.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 21/5/24.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    

    //@IBOutlet weak var ivCharacter: UIImageView!

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var ivCharacter: UIImageView!
    
    static let identifier = "CharacterCellIdentifier"
    static let nibName = "CharacterCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
