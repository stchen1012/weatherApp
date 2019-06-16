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
    
    let condition = ["01d", "01n", "02d", "02n", "03d", "03n", "04d", "04n", "09d", "09n", "10d", "10n", "11d", "11n", "13d","13n","50d", "50n"]

    let conditionImages: [UIImage] = [
        UIImage(named: "01d")!,
        UIImage(named: "01n")!,
        UIImage(named: "02d")!,
        UIImage(named: "02n")!,
        UIImage(named: "03d")!,
        UIImage(named: "03n")!,
        UIImage(named: "04d")!,
        UIImage(named: "04n")!,
        UIImage(named: "09d")!,
        UIImage(named: "09n")!,
        UIImage(named: "10d")!,
        UIImage(named: "10n")!,
        UIImage(named: "11d")!,
        UIImage(named: "11n")!,
        UIImage(named: "13d")!,
        UIImage(named: "13n")!,
        UIImage(named: "50d")!,
        UIImage(named: "50n")!]
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var rTime: UILabel!
    @IBOutlet weak var sTime: UILabel!
    @IBOutlet weak var wDescription: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var fiveDayDatesArray:[String] = []
    var fiveDayFormattedDatesArray:[String] = []
    var fiveDayIconArray:[String] = []
    var fiveDayDescArray:[String] = []
    var fiveDayTempMaxArray:[Int] = []
    var fiveDayTempMinArray:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        //tableView.delegate = self
        //tableView.dataSource = self
    
        
        let apiKey = "5d97ae5f72b3ee49baa9c85ecf0c73f1"
        let cityName = "New%20York"
        
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
                let dateFormatter = DateFormatter.init(withFormat: "hh:mm", locale: "")
                var dateString = dateFormatter.string(from: sunriseDate)
                let sunsetTime: Double = (weatherData?.sunset)!
                let sunsetDate = Date(timeIntervalSince1970: sunsetTime)
                let dateFormatterSunset = DateFormatter.init(withFormat: "hh:mm", locale: "")
                var dateStringSunset = dateFormatterSunset.string(from: sunsetDate)
 
                let descriptions = weatherData?.description ?? []
                var descriptionValue = ""
                if (descriptions.count > 0){
                    descriptionValue = descriptions[0].description ?? ""
                }
         
                self.temp.text = "\(currentTemp ?? 0)°"
                self.low.text = "L: \(minTemp ?? 0)°"
                self.high.text = "H: \(maxTemp ?? 0)°"
                self.rTime.text = "\(dateString)"
                self.wDescription.text = "\(descriptionValue)"
                self.sTime.text = "\(dateStringSunset)"
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
        }
 
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
                
                let weatherDataFiveDay = Mapper<WeatherFiveDay>().map(JSONObject: responseJSON)
                let dateFiveDay = weatherDataFiveDay?.listMain
                self.fiveDayDatesArray.append(String(dateFiveDay![0].dateTime!))
                self.fiveDayDatesArray += [String(dateFiveDay![9].dateTime!), String(dateFiveDay![18].dateTime!), String(dateFiveDay![27].dateTime!), String(dateFiveDay![36].dateTime!)]
                for i in self.fiveDayDatesArray {
                    let dateFiveDayTimeFormat = Date(timeIntervalSince1970: Double(i)!)
                    let dateFormatter = DateFormatter.init(withFormat: "MM/dd", locale: "")
                    var dateString = dateFormatter.string(from: dateFiveDayTimeFormat)
                    self.fiveDayFormattedDatesArray.append(dateString)
                }
                self.fiveDayIconArray.append((dateFiveDay![0].weatherListFive?[0].icon)!)
                self.fiveDayIconArray += [(dateFiveDay![9].weatherListFive?[0].icon)!, (dateFiveDay![18].weatherListFive?[0].icon)!, (dateFiveDay![27].weatherListFive?[0].icon)!, (dateFiveDay![36].weatherListFive?[0].icon)!]
                self.fiveDayDescArray.append((dateFiveDay![0].weatherListFive?[0].description)!)
                self.fiveDayDescArray += [(dateFiveDay![9].weatherListFive?[0].description)!, (dateFiveDay![18].weatherListFive?[0].description)!, (dateFiveDay![27].weatherListFive?[0].description)!, (dateFiveDay![36].weatherListFive?[0].description)!]
                self.fiveDayTempMaxArray.append(dateFiveDay![0].maxTemp!)
                self.fiveDayTempMaxArray += [dateFiveDay![9].maxTemp!, dateFiveDay![18].maxTemp!, dateFiveDay![27].maxTemp!, dateFiveDay![36].maxTemp!]
                self.fiveDayTempMinArray.append(dateFiveDay![0].minTemp!)
                self.fiveDayTempMinArray += [dateFiveDay![9].minTemp!, dateFiveDay![18].minTemp!, dateFiveDay![27].minTemp!, dateFiveDay![36].minTemp!]
                self.collectionView.reloadData()
        }
 
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell

        if fiveDayDatesArray.count == 5 || fiveDayDescArray.count == 5 || fiveDayTempMinArray.count == 5 || fiveDayTempMaxArray.count == 5  {
            cell.CVDate.text = "\(fiveDayFormattedDatesArray[indexPath.item])"
            cell.CVDesc.text = "\(fiveDayDescArray[indexPath.item])"
            cell.CVLow.text = "L: \(fiveDayTempMinArray[indexPath.item])°"
            cell.CVHigh.text = "H: \(fiveDayTempMaxArray[indexPath.item])°"
            cell.weatherIcon.image = UIImage(named: fiveDayIconArray[indexPath.item])
            }
        return cell
    }
    
}

