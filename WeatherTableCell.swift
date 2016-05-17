//
//  WeatherTableCell.swift
//  WeatherTracker_IOS
//
//  Created by Andreas on 2016-04-28.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

class WeatherTableCell: UITableViewCell {

    @IBOutlet weak var dagLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var stadLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
