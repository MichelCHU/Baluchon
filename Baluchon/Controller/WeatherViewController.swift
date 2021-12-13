//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Square on 26/10/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK:- IBOULET
    @IBOutlet weak var cityNewYorkTextField: UITextField!
    @IBOutlet weak var cityParisTextField: UITextField!
    @IBOutlet weak var tempOfNewYork: UILabel!
    @IBOutlet weak var tempMinOfNewYork: UILabel!
    @IBOutlet weak var tempMaxofNewYork: UILabel!
    @IBOutlet weak var tempMinOfParis: UILabel!
    @IBOutlet weak var tempOfParis: UILabel!
    @IBOutlet weak var tempMaxOfParis: UILabel!
    @IBOutlet weak var descriptionNewYorkLabel: UILabel!
    @IBOutlet weak var descriptionParisLabel: UILabel!
    @IBOutlet weak var weatherIconOfNewYork: UIImageView!
    @IBOutlet weak var weatherIconOfParis: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    
    let service = WeatherService()
    
    override func viewDidLoad() {
        setUp()
        super.viewDidLoad()
        
    }
    
    func setUp() {
        service.getData{ result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let weather):
                    self.toogleActivityIndicator(shown: true)
                    self.tempMinOfNewYork.text = String(weather.list[0].main.tempMin.rounded()) + "°"
                    self.tempOfNewYork.text = String(weather.list[0].main.temp.rounded()) + "°"
                    self.tempMaxofNewYork.text = String(weather.list[0].main.tempMax.rounded()) + "°"
                    self.descriptionNewYorkLabel.text = weather.list[0].weather[0].weatherDescription
                    self.iconWeatherChanged(descriptions: weather.list[0].weather[0].weatherDescription, icon: self.weatherIconOfNewYork)
                    self.tempMinOfParis.text = String(weather.list[1].main.tempMin.rounded()) + "°"
                    self.tempOfParis.text = String(weather.list[1].main.temp.rounded()) + "°"
                    self.tempMaxOfParis.text = String(weather.list[1].main.tempMax.rounded()) + "°"
                    self.descriptionParisLabel.text = weather.list[1].weather[0].weatherDescription
                    self.iconWeatherChanged(descriptions: weather.list[1].weather[0].weatherDescription, icon: self.weatherIconOfParis)
                case .failure:
                    self.alertVC(title: "Failure", message: "Service is momentaly unavaible ")
                }
                self.toogleActivityIndicator(shown: false)
            }
        }
    }
    
    func iconWeatherChanged(descriptions: String, icon: UIImageView){
        
        if descriptions.contains("clouds") || descriptions.contains("mist") || descriptions.contains("drizzle") {
            icon.image = UIImage(named: "CloudySun")
        }
        
        if descriptions.contains("clear") || descriptions.contains("sun") {
            icon.image = UIImage(named: "Sunny")
        }
        
        if descriptions.contains("rain") {
            icon.image = UIImage(named: "Rainy")
        }
        
        if descriptions.contains("snow") || descriptions.contains("sleet") {
            icon.image = UIImage(named: "Snowy")
        }
        
        if descriptions.contains("thunderstorm") {
            icon.image = UIImage(named: "CloudyFlash")
        }
    }
    
    func toogleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
    }
}
