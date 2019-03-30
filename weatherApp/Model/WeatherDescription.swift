//
//  WeatherDescription.swift
//  weatherApp
//
//  Created by Benny on 3/30/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherDescription: Mappable {
    
    var id: Int?
    var main: String?
    var icon: String?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        icon <- map["icon"]
        description <- map["description"]
    }
    
    func initialize(id: Int, main: String, icon: String, description: String) -> WeatherDescription {
        self.id = id
        self.main = main
        self.icon = icon
        self.description = description
        return self
    }
}

