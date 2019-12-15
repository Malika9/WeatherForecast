//
//  Weather.json
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation

struct City : Codable {
	var id : Int?
	var name : String?
	var coord : Coord?
	var country : String?
	var timezone : Int?
	var sunrise : Int?
	var sunset : Int?
}
