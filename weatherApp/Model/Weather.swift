//
//  Weather.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/26/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    
    var currentTemp: Int?
    var maxTemp:Int?
    var minTemp:Int?
    var description:[Any]?
    var sunrise:Double?
    var sunset:Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        currentTemp    <- map["main.temp"]
        maxTemp        <- map["main.temp_max"]
        minTemp        <- map["main.temp_min"]
        description    <- map["weather"]
        sunrise        <- map["sys.sunrise"]
        sunset         <- map["sys.sunset"]
    }
    
    func initialize(currentTemp: Int, maxTemp: Int, minTemp: Int, description: [Any], sunrise: Double, sunset: Double) -> Weather {
        self.currentTemp = currentTemp
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.description = description
        self.sunrise = sunrise
        self.sunset = sunset
        return self
    }

    
}
