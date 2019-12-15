//
//  Weather.json
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation

struct List : Codable {
	var dt : Int?
	var main : Main?
	var weather : [Weather]?
	var clouds : Clouds?
	var wind : Wind?
	var sys : Sys?
	var dt_txt : String?
}
