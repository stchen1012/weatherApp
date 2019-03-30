//
//  ListModel.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/29/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

/* Check w BT - couldn't get this work?
import Foundation
import ObjectMapper

class ListModel: Mappable {
    var dateTime: String?
    var main: [Any]?
    var weather: [Any]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dateTime  <- map["dt_txt"]
        main  <- map["main"]
        weather  <- map["weather"]
    }
    
    func initalize(dateTime: String, main: [Any], weather: [Any]) -> ListModel
    {
        self.dateTime = dateTime
        self.main = main
        self.weather = weather
        return self
    }
}
*/
