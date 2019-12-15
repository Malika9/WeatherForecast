//
//  CardCell.swift
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
