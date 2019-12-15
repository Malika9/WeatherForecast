//
//  CityListVC
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit

class CityListVC: UIViewController {
    var wdCityArr = [WeatherDataModel]() //Prepared from json received
    var weatherDisplayModel = [WeatherDisplayModel]() //Same count as of wdCityArr

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        self.prepareDataModel()
    }

    private func prepareDataModel() {

        let dispatchGroup = DispatchGroup()

        let session = URLSession.shared
        let operation1 = BlockOperation(block: {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=delhi,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!
            dispatchGroup.enter()
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    if error != nil {return}
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    if let _ = jsonObject as? [String: Any] {
                        var dataModel = WeatherDataModel()
                        do {
                            dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                            print(dataModel)
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

        let operation2 = BlockOperation(block: {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=pune,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!
            dispatchGroup.enter()
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    if error != nil {return}
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    if let _ = jsonObject as? [String: Any] {

                        var dataModel = WeatherDataModel()
                        do {
                            dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                            print(dataModel)
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

        let operation3 = BlockOperation(block: {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=batala,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!
            dispatchGroup.enter()
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    if error != nil {return}
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    if let _ = jsonObject as? [String: Any] {
                        var dataModel = WeatherDataModel()
                        do {
                            dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                            print(dataModel)
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

        let operation4 = BlockOperation(block: {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=ambala,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!
            dispatchGroup.enter()
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    if error != nil {return}
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    if let _ = jsonObject as? [String: Any] {
                        var dataModel = WeatherDataModel()
                        do {
                            dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                            print(dataModel)
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

        let operation5 = BlockOperation(block: {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=amritsar,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!
            dispatchGroup.enter()
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                do {
                    if error != nil {return}
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    if let _ = jsonObject as? [String: Any] {
                        var dataModel = WeatherDataModel()
                        do {
                            dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                            print(dataModel)
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

        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
        operationQueue.addOperation(operation3)
        operationQueue.addOperation(operation4)
        operationQueue.addOperation(operation5)

        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            print("all done......")
            print(self.wdCityArr)
            self.prepareTableViewDataSource()
            self.tableView.reloadData()
        })
    }

    private func prepareTableViewDataSource() {
        for dataModel in wdCityArr { // 6 cities
            var displayModel = WeatherDisplayModel()
            var min_temp: Double = Double(Int.max)
            var max_temp: Double = Double(Int.min)
            let currentTime = Date().currentTimeMillis()
//            let currentTime = 1576399642 //Value for 2:10 pm
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
                }//1576422000   //1576432800

                let date = Date(timeIntervalSince1970: TimeInterval(slotStartTime))
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                dateFormatter.timeZone = .current
                let localDate = dateFormatter.string(from: date)
                print(localDate)
                print(slotStartTime)
                print()

                if currentTime >= slotStartTime {
                    displayModel.temp = slotData.main?.temp ?? 0
                    displayModel.humidity = slotData.main?.humidity ?? 0
                    displayModel.speed = slotData.wind?.speed ?? 0
                    let weather = slotData.weather?[0]
                    displayModel.weather = weather?.main ?? ""
                    isSlotFound = true
                    break //1576476000, 1576399642,  1576400400
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
            cell.lblCityName.text = self.weatherDisplayModel[indexPath.row].heading
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
            vc.cityWeatherData = self.wdCityArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
