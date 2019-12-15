//
//  Weather.json
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import Foundation

struct Weather : Codable {
	var id : Int?
	var main : String?
	var description : String?
	var icon : String?
}
