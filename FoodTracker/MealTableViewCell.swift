//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by csair on 2018/5/3.
//  Copyright © 2018年 Pop Team Epic. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    // mark properties
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
