//
//  ViewController.swift
//  weatherApp
//
//  Created by Tracy Chen on 3/25/19.
//  Copyright © 2019 Tracy. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
//    let condition = ["Sunny", "Cloudy", "Windy", "Rain", "Snow"] // change to icon number
//
//    let conditionImages: [UIImage] = [
//        UIImage(named: "sunny")!,
//        UIImage(named: "cloudy")!,
//        UIImage(named: "windy")!,
//        UIImage(named: "rain")!,
//        UIImage(named: "snow")!]
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var rTime: UILabel!
    @IBOutlet weak var sTime: UILabel!
    @IBOutlet weak var wDescription: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //tableView.delegate = self
        //tableView.dataSource = self
    
        
        let apiKey = "5d97ae5f72b3ee49baa9c85ecf0c73f1"
        let cityName = "New%20York"
        
    /*
        AF.request("https://api.openweathermap.org/data/2.5/weather?APPID=\(apiKey)&q=\(cityName)&units=imperial").responseJSON
            { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                

                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    print("Error reading response")
                    return
                }
                
                let weatherData = Mapper<Weather>().map(JSONObject: responseJSON)
                let currentTemp = weatherData?.currentTemp
                let minTemp = weatherData?.minTemp
                let maxTemp = weatherData?.maxTemp
                let sunriseTime:Double = (weatherData?.sunrise)!
                let sunriseDate = Date(timeIntervalSince1970: sunriseTime)
//                let dateFormatter = DateFormatter()
//                dateFormatter.timeZone = TimeZone(abbreviation: "EST")
//                dateFormatter.locale = NSLocale.current
//                dateFormatter.dateFormat = "HH:mm"
//                let sunriseStr = dateFormatter.string(from: weatherData?.sunrise)
                let description = weatherData?.description as? [[String: Any]]
                let descriptionValue = description![0]["description"]!
         
                self.temp.text = "\(currentTemp ?? 0)°"
                self.low.text = "L: \(minTemp ?? 0)°"
                self.high.text = "H: \(maxTemp ?? 0)°"
                self.rTime.text = "\(sunriseDate)"
                self.wDescription.text = "\(descriptionValue)"
                
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
                
        }
        */
        
        
        AF.request("https://api.openweathermap.org/data/2.5/forecast?APPID=\(apiKey)&q=\(cityName)&units=imperial").responseJSON
            { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    print("Error reading response")
                    return
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
                
                let fiveDayWeather = Mapper<WeatherFiveDay>().map(JSONObject: responseJSON)
                let date = fiveDayWeather?.date
                let maxTemp = fiveDayWeather?.maxTemp
                let minTemp = fiveDayWeather?.minTemp
                print("THIS IS THE MAXTEMP \(maxTemp)")
                print("THIS IS THE MAXTEMP \(minTemp)")
        }
 
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MAKE SURE YOU REMEMBER TO CLASSIFY "CELL" AS THE IDENTIFIER - FOR FUTURE REFERENCE - otherwise app crashes
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell
        //cell.weatherIcon.image = self.conditionImages[(indexPath.item)]
        return cell
    }
    
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        tableViewCell.textLabel?.text = "test"
        return tableViewCell
    }
 */
    
    
}

