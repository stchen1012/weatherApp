//
//  weatherFiveDay.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/27/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherFiveDay: Mappable {
    
    var date: String?
    var maxTemp:Int?
    var minTemp:Int?
    var description:String?
    var icon: Any?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date           <- map["list.dt_txt"]
        maxTemp        <- map["list.main.temp_max"]
        minTemp        <- map["list.main.temp_min"]
        icon           <- map["list.weather.icon"]
        description    <- map["list.weather.description"]
    }
    
    func initialize(date:String, maxTemp: Int, minTemp: Int, description: String, icon: Any) -> WeatherFiveDay {
        self.date = date
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.description = description
        self.icon = icon
        return self
    }
}
