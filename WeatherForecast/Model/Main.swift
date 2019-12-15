//
//  Weather.json
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation

struct Main : Codable {
	var temp : Double?
	var feels_like : Double?
	var temp_min : Double?
	var temp_max : Double?
	var pressure : Int?
	var sea_level : Int?
	var grnd_level : Int?
	var humidity : Int?
	var temp_kf : Double?
}
