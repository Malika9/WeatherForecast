//
//  CityListVC
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit

class CityListVC: UIViewController {
    private var wdCityArr = [WeatherDataModel]() //Prepared from json received
    private var weatherDisplayModel = [WeatherDisplayModel]() //Same count as of wdCityArr
    private var cities = Utils.cities
    private var operations = [BlockOperation]()
    private let activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnAddLocationTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCityVC") as? AddCityVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        activityIndicator.frame = self.view.frame
        activityIndicator.style = .gray
        self.view.addSubview(activityIndicator)
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        self.prepareDataModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        if cities.count != Utils.cities.count {
            self.prepareDataModel()
        } else {
            self.tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    private func prepareDataModel() {
        self.cities = Utils.cities
        let dispatchGroup = DispatchGroup()
        let session = URLSession.shared
        let operationQueue = OperationQueue()
        self.wdCityArr.removeAll()
        for city in self.cities {
            let operation = BlockOperation(block: {
                let cityUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city),ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")
                guard let url = cityUrl else {return}
                dispatchGroup.enter()
                let task = session.dataTask(with: url, completionHandler: { data, response, error in
                    do {
                        if error != nil {return}
                        let jsonObject = try JSONSerialization.jsonObject(with: data!)
                        if let _ = jsonObject as? [String: Any] {
                            var dataModel = WeatherDataModel()
                            do {
                                dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                                self.wdCityArr.append(dataModel)
                                dispatchGroup.leave()
                            } catch {
                                print("city details not found")
                                dispatchGroup.leave()
                            }
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                })
                task.resume()
            })
            self.operations.append(operation)
            operationQueue.addOperation(operation)
        }

        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.prepareTableViewDataSource()
            self.tableView.reloadData()
        })
    }

    private func prepareTableViewDataSource() {
        for dataModel in wdCityArr {
            var displayModel = WeatherDisplayModel()
            var min_temp: Double = Double(Int.max)
            var max_temp: Double = Double(Int.min)
            let currentTime = Date().currentTimeMillis()
            guard let listArr = dataModel.list else {return}
            var isSlotFound = false
            for i in 0..<8 {
                let slotData = listArr[i]
                guard let slotMinTemp = slotData.main?.temp_min, let slotMaxTemp = slotData.main?.temp_max, let slotStartTime = slotData.dt else {return}
                if min_temp > slotMinTemp{
                    min_temp = slotMinTemp
                }
                if max_temp < slotMaxTemp {
                    max_temp = slotMaxTemp
                }

                if currentTime >= slotStartTime {
                    displayModel.temp = slotData.main?.temp ?? 0
                    displayModel.humidity = slotData.main?.humidity ?? 0
                    displayModel.speed = slotData.wind?.speed ?? 0
                    let weather = slotData.weather?[0]
                    displayModel.weather = weather?.main ?? ""
                    isSlotFound = true
                    break
                }
            }
            displayModel.heading = dataModel.city?.name
            displayModel.min_temp = min_temp
            displayModel.max_temp = max_temp
            if !isSlotFound {
                displayModel.temp = listArr[7].main?.temp ?? 0
                displayModel.humidity = listArr[7].main?.humidity ?? 0
                displayModel.speed = listArr[7].wind?.speed ?? 0
                let weather = listArr[7].weather?[0]
                displayModel.weather = weather?.main ?? ""
            }
            weatherDisplayModel.append(displayModel)
        }
    }
}

extension CityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wdCityArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardCell {
            cell.selectionStyle = .none
            cell.lblCityName.text = self.weatherDisplayModel[indexPath.row].heading?.uppercased()
            cell.lblTemp.text = "\(self.weatherDisplayModel[indexPath.row].temp ?? 0)"
            cell.lblMinTemp.text = "\(self.weatherDisplayModel[indexPath.row].min_temp ?? 0)"
            cell.lblMaxTemp.text = "\(self.weatherDisplayModel[indexPath.row].max_temp ?? 0)"
            cell.lblHumidity.text = "\(self.weatherDisplayModel[indexPath.row].humidity ?? 0)"
            cell.lblWeatherType.text = self.weatherDisplayModel[indexPath.row].weather
            cell.lblWindSpeed.text = "\(self.weatherDisplayModel[indexPath.row].speed ?? 0)"
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CityDetailsVC") as? CityDetailsVC {
//            self.wdCityArr.forEach({
//                if $0.city?.name == weatherDisplayModel[indexPath.row].heading {
//                    vc.cityWeatherData = $0
//                    return
//                }
//            })
            vc.cityWeatherData = self.wdCityArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
