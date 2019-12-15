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

//    enum CodingKeys: String, CodingKey {
//
//        case cod = "cod"
//        case message = "message"
//        case cnt = "cnt"
//        case list = "list"
//        case city = "city"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        cod = try values.decodeIfPresent(String.self, forKey: .cod)
//        message = try values.decodeIfPresent(Int.self, forKey: .message)
//        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
//        list = try values.decodeIfPresent([List].self, forKey: .list)
//        city = try values.decodeIfPresent(City.self, forKey: .city)
//    }

}

struct WeatherDisplayModel {
    var heading: String?
    var temp: Double?
    var min_temp: Double?
    var max_temp: Double?
    var humidity: Int?
    var speed: Double?
    var weather: String?

//    enum CodingKeys: String, CodingKey {
//
//        case temp = "temp"
//        case min_temp = "min_temp"
//        case max_temp = "max_temp"
//        case humidity = "humidity"
//        case speed = "speed"
//        case weather = "weather"
//    }

//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
//        min_temp = try values.decodeIfPresent(Double.self, forKey: .min_temp)
//        max_temp = try values.decodeIfPresent(Double.self, forKey: .max_temp)
//        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
//        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
//        weather = try values.decodeIfPresent(String.self, forKey: .weather)
//    }

}
