//
//  WeatherManager.swift
//  weather
//
//  Created by Meddor on 19.02.2023.
//

import Foundation
import CoreLocation

protocol WeatherMenegerProtocol: AnyObject {
    func updateWeatherData(model: CurrentWeatherModel)
    func showError(error: Error)
}

struct WeatherMeneger {
    weak var delegat: WeatherMenegerProtocol?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=2a4c9e1fb620ada6de995741ee21a30a&units=metric"
    
    func fetchWeatherString(sityName: String) {
        let URLString = "\(weatherURL)&q=\(sityName)"
        performRequest(URLString: URLString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(URLString: URLString)
    }
    
    func performRequest(URLString: String) {
        if let url = URL(string: URLString){  //Создаем URL
            let session = URLSession(configuration: .default) //Создаем URLСессию
            let task = session.dataTask(with: url) { data, responce, error in  //Создать задание для Сесии
                if error != nil {
                    delegat?.showError(error: error!)
                    return
                }
                if let dataFromeJson = data {
                    jsonDecoder(data: dataFromeJson)
                }//Запускаем задачу
            }
            task.resume()
        }
    }
    func jsonDecoder(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(BaseWeatherModel.self, from: data)
            let model = CurrentWeatherModel(id: decodeData.weather[0]?.id ?? 0,
                                            cityName: decodeData.name ?? "",
                                            description: decodeData.weather[0]?.description ?? "",
                                            feelsLike: decodeData.main?.feels_like ?? 0.0,
                                            temp: decodeData.main?.temp ?? 0.0,
                                            min: decodeData.main?.temp_min ?? 0.0,
                                            max: decodeData.main?.temp_max ?? 0.0)
            delegat?.updateWeatherData(model: model)
        } catch {
            delegat?.showError(error: error)
        }
    }
}
