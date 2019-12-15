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

//    enum CodingKeys: String, CodingKey {
//
//        case dt = "dt"
//        case main = "main"
//        case weather = "weather"
//        case clouds = "clouds"
//        case wind = "wind"
//        case sys = "sys"
//        case dt_txt = "dt_txt"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
//        main = try values.decodeIfPresent(Main.self, forKey: .main)
//        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
//        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
//        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
//        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
//        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)
//    }

}
