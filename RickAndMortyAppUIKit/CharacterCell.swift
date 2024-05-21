//
//  CharacterCell.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 21/5/24.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var ivCharacter: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    static let identifier = "CharacterCellIdentifier"
    static let nibName = "CharacterCell"
    static let height: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
