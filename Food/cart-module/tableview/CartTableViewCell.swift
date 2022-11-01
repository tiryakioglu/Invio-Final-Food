//
//  CartTableViewCell.swift
//  Food
//
//  Created by Ali Tiryakioğlu on 31.10.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cartFoodImage: UIImageView!
    
    @IBOutlet weak var cartFoodNameLabel: UILabel!
    
    @IBOutlet weak var cartFoodPriceLabel: UILabel!
    
    @IBOutlet weak var cartFoodCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
