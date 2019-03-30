//
//  ForecastW.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/29/19.
//  Copyright © 2019 Tracy. All rights reserved.
//


import Foundation
import ObjectMapper

class ForecastW: Mappable {
    
    var list: [WeatherFiveDay]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        list <- map["list"]
    }
    
    func initialize(list: [WeatherFiveDay]) -> ForecastW {
        self.list = list
        return self
    }
}

