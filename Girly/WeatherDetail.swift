//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Bridget Falkenhayn on 3/14/22.
//

import Foundation
import UIKit
private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
}()

private let hourFormatter: DateFormatter = {
    let hourFormatter = DateFormatter()
    hourFormatter.dateFormat = "ha"
    return hourFormatter
}()


struct DailyWeather: Codable {
    var dailyIcon: String
    var dailyWeekDay: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
}
struct HourlyWeather: Codable {
    var hourlyIcon: String
    var hour: String
    var hourlyTemp: Int
}

class WeatherDetail: WeatherLocation {
    
    
    private struct Result: Codable {
        var timezone: String
        var current: Current
        var daily: [Daily]
        var hourly: [Hourly]
    }

    
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dayIcon = ""
    var dailyWeatherData: [DailyWeather] = []
    var hourlyWeatherData: [HourlyWeather] = []
    
    
    private struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    private struct Weather: Codable {
        var description: String
        var icon: String
        var id: Int
    }
    private struct Daily: Codable {
        var dt: TimeInterval
        var temp: Temp
        var weather: [Weather]
    }
    private struct Temp: Codable {
        var max: Double
        var min: Double
    }
    
    private struct Hourly: Codable {
        var temp: Double
        var dt: TimeInterval
        var weather: [Weather]
    }
    

    
    let result = JSONDecoder()
    
    func getData (completed: @escaping () -> ()) {
        print("lets see if the function is even getting called")
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIKeys.openWeatherKey)"
        guard let url = URL(string: urlString) else {
            print("could not create URL")
             completed()
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url)
            { (data, response, error) in
            if let error = error { print(error.localizedDescription )
            }
            do {
                //             let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print( "time zone is \(result.timezone)")
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dayIcon = self.fileNameForIcon(icon: result.current.weather[0].icon)
                for index in 0..<result.daily.count {
                    let weekdayDate = Date(timeIntervalSince1970: result.daily[index].dt)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekday = dateFormatter.string(from: weekdayDate)
                    let dailyIcon = self.fileNameForIcon(icon: result.daily[index].weather[0].icon)
                    let dailySummary = result.daily[index].weather[0].description
                    let dailyHigh = Int(result.daily[index].temp.max.rounded())
                    let dailyLow = Int(result.daily[index].temp.min.rounded())
                    let dailyWeather = DailyWeather(dailyIcon: dailyIcon, dailyWeekDay: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                    self.dailyWeatherData.append(dailyWeather)
                }
                let lastHour = min(24, result.hourly.count)
                if lastHour > 0 {
                    for index in 1...lastHour {
                        let hourlyDate = Date(timeIntervalSince1970: result.hourly[index].dt)
                        hourFormatter.timeZone = TimeZone(identifier: result.timezone)
                        let hour = hourFormatter.string(from: hourlyDate)
//                        let hourlyIcon = self.fileNameForIcon(icon: result.hourly[index].weather[0].icon)
                        let hourlyIcon = self.systemNameFromID(id: result.hourly[index].weather[0].id, icon: result.hourly[index].weather[0].icon)
                    
    //                    let hourlyTemp = Int(result.hourly[index].temp)
                        let hourlyTemp = Int(result.hourly[index].temp)
                        let hourlyWeather = HourlyWeather(hourlyIcon: hourlyIcon, hour: hour, hourlyTemp: hourlyTemp)
                        self.hourlyWeatherData.append(hourlyWeather)
                 
                    }
                }
                
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
    func fileNameForIcon(icon: String) -> String {
        var newFileName = ""
        switch icon {
        case "01d", "01n":
            newFileName =  "☀️"
        case "02d", "02n":
            newFileName =  "🌤"
        case "03d", "03n":
            newFileName =  "⛅️"
        case "04d", "04n":
            newFileName =  "🌥"
        case "09d", "09n":
            newFileName =  "🌧"
        case "10d", "10n":
            newFileName =  "🌧"
        case "11d", "11n":
            newFileName =  "⛈"
        case "13d", "13n":
            newFileName =  "❄️"
        case "05d", "05n":
            newFileName =  "🌧"
        default:
            newFileName =  "clear sky"
        }
        return newFileName
    }
    private func   systemNameFromID(id: Int, icon:String) -> String {
        switch id {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "cloud.drizzle"
        case 500, 501, 520, 521, 531:
            return "cloud.rain"
        case 502, 503, 504, 522:
            return "cloud.heavyrain"
        case 511, 611...616 :
            return "sleet"
        case 600...602, 620...622:
            return "snow"
        case 701, 711, 741:
            return "cloud.fog"
        case 721:
            return (icon.hasSuffix("d") ? "sun.haze" : "cloud.fog")
        case 731, 751, 761, 762:
            return (icon.hasSuffix("d") ? "sun.dust" : "cloud.fog")
        case 771:
            return "wind"
        case 781:
            return "tornado"
        case 800:
            return  (icon.hasSuffix("d") ? "sun.max" : "moon")
        case 801, 802:
            return (icon.hasSuffix("d") ? "cloud.sun" : "cloud.moon")
        case 803, 804:
            return "cloud"
        default:
            return "questionmark.diamond"
        }
    }
    
}
