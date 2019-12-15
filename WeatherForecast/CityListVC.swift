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
        prepareDataModel()
    }

    private func prepareDataModel() {

        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=delhi,ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")!

        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data!)
                if let _ = jsonObject as? [String: Any] {

                    var dataModel = WeatherDataModel()
                    dataModel = try! JSONDecoder().decode(WeatherDataModel.self, from: data!)
                    print(dataModel)
                    self.wdCityArr.append(dataModel)
                    self.prepareTableViewDataSource()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("JSONSerialization error:", error)
            }
        })
        task.resume()
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
                }

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
        return 5 //self.wdCityArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardCell {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
