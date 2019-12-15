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

//    enum CodingKeys: String, CodingKey {
//
//        case temp = "temp"
//        case feels_like = "feels_like"
//        case temp_min = "temp_min"
//        case temp_max = "temp_max"
//        case pressure = "pressure"
//        case sea_level = "sea_level"
//        case grnd_level = "grnd_level"
//        case humidity = "humidity"
//        case temp_kf = "temp_kf"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
//        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
//        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
//        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
//        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
//        sea_level = try values.decodeIfPresent(Int.self, forKey: .sea_level)
//        grnd_level = try values.decodeIfPresent(Int.self, forKey: .grnd_level)
//        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
//        temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf)
//    }

}
