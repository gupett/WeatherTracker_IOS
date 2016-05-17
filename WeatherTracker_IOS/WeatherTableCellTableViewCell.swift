//
//  WeatherTableCellTableViewCell.swift
//  WeatherTracker_IOS
//
//  Created by Thim on 17/05/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class WeatherTableCell: UITableViewCell {
    
    
    @IBOutlet weak var LabelStad: UILabel!
    @IBOutlet weak var LabelDatum: UILabel!
    @IBOutlet weak var WeatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
