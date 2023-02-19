//
//  ViewController.swift
//  weather
//
//  Created by Meddor on 18.02.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherMeneger()
    var location = CLLocationManager()
    var backcolor = #colorLiteral(red: 0.8913460374, green: 0.882619977, blue: 0.8476091027, alpha: 1)
    var tintColor = #colorLiteral(red: 0.8002961278, green: 0.7723649144, blue: 0.72442168, alpha: 1)
    
    lazy var geoButton: UIButton = {
        var view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "location"), for: .normal)
        view.backgroundColor = tintColor
        view.tintColor = .brown
        view.addTarget(self, action: #selector(pressedLocation), for: .touchUpInside)
        return view
    }()
    var textFieldSearch: UITextField = {
        var view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 18)
        view.placeholder = "Search"
        view.backgroundColor = #colorLiteral(red: 0.8002961278, green: 0.7723649144, blue: 0.72442168, alpha: 1)

        return view
    }()
    lazy var searchButton: UIButton = {
        var view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.backgroundColor = tintColor
        view.tintColor = .brown

        return view
    }()
    let labelNameSity: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 40)
        view.text = "SAN FRANCISCO"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9207007289, green: 0.3671361208, blue: 0.1540047526, alpha: 1)
        
        
        return view
    }()
    let labelWeatherDescription: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
        view.text = "Today clear"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9207007289, green: 0.3671361208, blue: 0.1540047526, alpha: 1)
        return view
    }()
    let temperatureLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 70)
        view.text = "22.5"
        view.textAlignment = .center
        view.textColor = #colorLiteral(red: 0.9207007289, green: 0.3671361208, blue: 0.1540047526, alpha: 1)
        return view
    }()
    let temperatureMinLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        view.text = ""
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = #colorLiteral(red: 0.9207007289, green: 0.3671361208, blue: 0.1540047526, alpha: 1)
        return view
    }()
    let temperatureMaxLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        view.text = ""
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = #colorLiteral(red: 0.9207007289, green: 0.3671361208, blue: 0.1540047526, alpha: 1)
        return view
    }()
    let imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .brown
        view.image = UIImage(systemName: "")
        return view
    }()
    var topStack: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 10
        
        return view
    }()
    var rootStack: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backcolor
        ns()
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
        textFieldSearch.delegate = self
        weatherManager.delegat = self
        weatherManager.fetchWeatherString(sityName: "moscow")
    }
    @objc func pressedLocation() {
        location.requestLocation()
    }
    func ns() {
        view.addSubview(topStack)
        topStack.addArrangedSubview(geoButton)
        topStack.addArrangedSubview(textFieldSearch)
        topStack.addArrangedSubview(searchButton)
        NSLayoutConstraint.activate([
            topStack.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            topStack.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            geoButton.heightAnchor.constraint(equalToConstant: 64),
            geoButton.widthAnchor.constraint(equalToConstant: 64),
            textFieldSearch.heightAnchor.constraint(equalToConstant: 64),
            searchButton.heightAnchor.constraint(equalToConstant: 64),
            searchButton.widthAnchor.constraint(equalToConstant: 64),
        ])
        view.addSubview(rootStack)
        rootStack.addArrangedSubview(labelNameSity)
        rootStack.addArrangedSubview(labelWeatherDescription)
        rootStack.addArrangedSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            rootStack.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            rootStack.topAnchor.constraint(equalTo: topStack.bottomAnchor,constant: 450),
            rootStack.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 120)
        ])
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topStack.bottomAnchor,constant: 50),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 60),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -60),
            imageView.bottomAnchor.constraint(equalTo: rootStack.topAnchor,constant: -70)
        ])
        view.addSubview(temperatureMinLabel)
        view.addSubview(temperatureMaxLabel)
        NSLayoutConstraint.activate([
            temperatureMinLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            temperatureMinLabel.topAnchor.constraint(equalTo: temperatureLabel.topAnchor,constant: 33),
            temperatureMinLabel.heightAnchor.constraint(equalToConstant: 60),
            temperatureMinLabel.widthAnchor.constraint(equalToConstant: 60),
            
            temperatureMaxLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            temperatureMaxLabel.topAnchor.constraint(equalTo: temperatureLabel.topAnchor,constant: 33),
            temperatureMaxLabel.heightAnchor.constraint(equalToConstant: 60),
            temperatureMaxLabel.widthAnchor.constraint(equalToConstant: 60),

        ])
    }
}
//MARK: - UITextFielDelegate Ловит данные из TextFeld
extension ViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {//Проверка на пустой текст(делегат тоже для этого)
            return true
        } else {
            textField.placeholder = "Введите название города"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason){
        let text = textField.text ?? ""         //получает текст из textField
        weatherManager.fetchWeatherString(sityName: text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
//MARK: - WeatherMeneherDelegate Получаем танные из API (Декодированные)
extension ViewController: WeatherMenegerProtocol {
    func updateWeatherData(model: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.labelNameSity.text = model.cityName
            self.labelWeatherDescription.text = model.description
            self.temperatureLabel.text = "\(String(model.temp))°"
            self.imageView.image = UIImage(systemName: model.icon)
            self.temperatureMinLabel.text = "Min \(String(model.min))"
            self.temperatureMaxLabel.text = "Max \(String(model.max))"
        }
    }
    func showError(error: Error) {
        print("🤯\(error)")
    }
}
//MARK: - CLLocationManagerDelegate Для получения местонахождения пользлвателя
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            location.stopUpdatingLocation()
            let lat = locations[0].coordinate.latitude
            let log = locations[0].coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: log)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🤯\(error)")
    }
}
