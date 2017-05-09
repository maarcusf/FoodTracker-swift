//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //Propriedades
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingsField: StarRatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
