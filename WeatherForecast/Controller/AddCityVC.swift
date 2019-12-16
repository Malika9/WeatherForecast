//
//  AddCityVC.swift
//  WeatherForecast
//
//  Created by Malika Arora on 15/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit
import CoreLocation

class AddCityVC: UIViewController {
    private var cities = DataManager.cities
    private var locationManager = CLLocationManager()
    private var currentLoc: CLLocation?
    private var currentCityDataModel = WeatherDataModel()
    private let session = URLSession.shared

    @IBOutlet private weak var tableView: UITableView!

    @IBAction private func btnAddCurrentLocationTapped(_ sender: UIButton) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            guard let lat = currentLoc?.coordinate.latitude, let long = currentLoc?.coordinate.longitude else {self.showAlert(message: "Sorry! Couldn't get your location"); return}
            self.getCityDataForLatLong(lat: lat, long: long)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension AddCityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.cities[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9725490196, alpha: 1)
        return cell
    }

    private func getCityDataForLatLong(lat: Double, long: Double) {
        let latLongUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")
        guard let url = latLongUrl else {return}
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                if error != nil {return}
                let jsonObject = try JSONSerialization.jsonObject(with: data!)
                if let _ = jsonObject as? [String: Any] {
                    var dataModel = WeatherDataModel()
                    do {
                        dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                        let cityName = dataModel.city?.name
                        let countryCode = dataModel.city?.country
                        if self.cities.contains(cityName!) {self.showAlert(message: "City already added"); return}
                        DataManager.cities.append(cityName ?? "")
                        self.cities.append(cityName ?? "")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        self.getWeatherDataForCity(city: cityName!, country: countryCode!)

                    } catch {
                        print("city details not found")
                    }
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        })
        task.resume()
    }

    private func getWeatherDataForCity(city: String, country: String) {
        let cityURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city),\(country)&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")
        guard let url = cityURL else {return}
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                if error != nil {return}
                let jsonObject = try JSONSerialization.jsonObject(with: data!)
                if let _ = jsonObject as? [String: Any] {
                    var dataModel = WeatherDataModel()
                    do {
                        dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                        DataManager.weatherCityDataArr.append(dataModel)
                        self.prepareDisplayModelForCurrentCityData(dataModel: dataModel)
                    } catch {
                        print("city details not found")
                    }
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        })
        task.resume()
    }

    private func prepareDisplayModelForCurrentCityData(dataModel: WeatherDataModel) {
        Utils.prepareDisplayModel(dataModel: dataModel)
    }
}
