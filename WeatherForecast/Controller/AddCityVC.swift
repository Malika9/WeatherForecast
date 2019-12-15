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
    private var cities = Utils.cities
    private var locationManager = CLLocationManager()
    private var currentLoc: CLLocation?

    @IBOutlet weak var tableView: UITableView!

    @IBAction func btnAddCurrentLocationTapped(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            guard let lat = currentLoc?.coordinate.latitude, let long = currentLoc?.coordinate.longitude else {self.showAlert(); return}
            self.hitAPIFor(lat: lat, long: long)
            print(currentLoc?.coordinate.latitude)
            print(currentLoc?.coordinate.longitude)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func showAlert() {
        let alertVC = UIAlertController(title: "Information", message: "Sorry! Couldn't get your location", preferredStyle: .alert)
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

    private func hitAPIFor(lat: Double, long: Double) {
        let session = URLSession.shared
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
                        if self.cities.contains(cityName!) {return}
                        Utils.cities.append(cityName ?? "")
                        self.cities.append(cityName ?? "")
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
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
}

extension AddCityVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if(status == .authorizedWhenInUse ||
//            status == .authorizedAlways) {
//            currentLoc = locationManager.location
//            guard let lat = currentLoc?.coordinate.latitude, let long = currentLoc?.coordinate.longitude else {return}
//            self.hitAPIFor(lat: lat, long: long)
//            print(currentLoc?.coordinate.latitude)
//            print(currentLoc?.coordinate.longitude)
//        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
