//
//  MainFive.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/30/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

// for 5 day Main object
import Foundation
import ObjectMapper

class MainFive: Mappable {
    var dateTime: Double?
    var minTemp: Int?
    var maxTemp: Int?
    var weatherListFive: [WeatherFive]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateTime      <- map["dt"]
        minTemp       <- map["main.temp_min"]
        maxTemp       <- map["main.temp_max"]
        weatherListFive <- map["weather"]
    }
    
    func initialize(dateTime: Double, minTemp: Int, maxTemp: Int, weatherListFive: [WeatherFive]) -> MainFive {
        self.weatherListFive = weatherListFive
        self.dateTime = dateTime
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        return self
    }
}
