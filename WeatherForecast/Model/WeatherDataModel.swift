//
//  Weather.json
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation

struct WeatherDataModel : Codable {
	var cod : String?
	var message : Int?
	var cnt : Int?
	var list : [List]?
	var city : City?
}

struct WeatherDisplayModel {
    var heading: String?
    var temp: Double?
    var min_temp: Double?
    var max_temp: Double?
    var humidity: Int?
    var speed: Double?
    var weather: String?
}
