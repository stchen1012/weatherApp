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
    var listMain: [MainFive]

    required init?(map: Map) {
        self.listMain = []
    }
    
    func mapping(map: Map) {
        listMain       <- map["list"]
    }
    
    func initialize(listMain: [MainFive]) -> WeatherFiveDay {
        self.listMain = listMain
        return self
    }
}




