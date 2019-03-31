//
//  WeatherFive.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/30/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

//for 5 day Weather object
import Foundation
import ObjectMapper

class WeatherFive: Mappable {
    var description:String?
    var icon:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        description    <- map["main"]
        icon           <- map["icon"]
    }
    
    func initialize(description: String, icon: String) -> WeatherFive {
        self.description = description
        self.icon = icon
        return self
    }
}
