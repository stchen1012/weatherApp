//
//  Forecast.swift
//  weatherApp
//
//  Created by Benny on 3/28/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

import Foundation
import ObjectMapper

class Forecast: Mappable {
    
    var list: [Weather]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        list <- map["list"]
    }
    
    func initialize(list: [Weather]) -> Forecast {
        self.list = list
        return self
    }
}
