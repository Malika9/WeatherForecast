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

//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case main = "main"
//        case description = "description"
//        case icon = "icon"
//    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        main = try values.decodeIfPresent(String.self, forKey: .main)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        icon = try values.decodeIfPresent(String.self, forKey: .icon)
//    }

}
