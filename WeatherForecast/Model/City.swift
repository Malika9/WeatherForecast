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

//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case coord = "coord"
//        case country = "country"
//        case timezone = "timezone"
//        case sunrise = "sunrise"
//        case sunset = "sunset"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
//        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
//        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
//    }

}
