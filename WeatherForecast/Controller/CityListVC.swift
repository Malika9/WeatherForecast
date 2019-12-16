//
//  CityListVC
//  WeatherForecast
//
//  Created by Malika Arora on 14/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit

class CityListVC: UIViewController {
    private var cities = DataManager.cities
    private var operations = [BlockOperation]()
    private let activityIndicator = UIActivityIndicatorView()

    @IBOutlet private weak var tableView: UITableView!
    @IBAction private func btnAddLocationTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCityVC") as? AddCityVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        self.addLoader()
        self.getDataFromServer()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    private func addLoader() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.style = .gray
    }

    private func getDataFromServer() {
        self.cities = DataManager.cities
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let session = URLSession.shared
        let operationQueue = OperationQueue()
        DataManager.weatherCityDataArr.removeAll()
        for city in self.cities {
            let operation = BlockOperation(block: {
                dispatchGroup.enter()
                let cityUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city),ind&APPID=e5b58e04d5d0ad76fde7b45a14fa0f79")
                guard let url = cityUrl else {return}
                let task = session.dataTask(with: url, completionHandler: { data, response, error in
                    do {
                        if error != nil {return}
                        let jsonObject = try JSONSerialization.jsonObject(with: data!)
                        if let _ = jsonObject as? [String: Any] {
                            var dataModel = WeatherDataModel()
                            do {
                                dataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data!)
                                DataManager.weatherCityDataArr.append(dataModel)
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
        dispatchGroup.leave()

        // Executed after all data is fetched
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.prepareWeatherDisplayModelArray()
            self.tableView.reloadData()
        })
    }

    private func prepareWeatherDisplayModelArray() {
        for dataModel in DataManager.weatherCityDataArr {
            Utils.prepareDisplayModel(dataModel: dataModel)
        }
    }
}

extension CityListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.weatherDisplayArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardCell {
            cell.selectionStyle = .none
            cell.lblCityName.text = DataManager.weatherDisplayArr[indexPath.row].heading?.uppercased()
            cell.lblTemp.text = "\(DataManager.weatherDisplayArr[indexPath.row].temp ?? 0)"
            cell.lblMinTemp.text = "\(DataManager.weatherDisplayArr[indexPath.row].min_temp ?? 0)"
            cell.lblMaxTemp.text = "\(DataManager.weatherDisplayArr[indexPath.row].max_temp ?? 0)"
            cell.lblHumidity.text = "\(DataManager.weatherDisplayArr[indexPath.row].humidity ?? 0)"
            cell.lblWeatherType.text = DataManager.weatherDisplayArr[indexPath.row].weather
            cell.lblWindSpeed.text = "\(DataManager.weatherDisplayArr[indexPath.row].speed ?? 0)"
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CityDetailsVC") as? CityDetailsVC {
            vc.cityWeatherData = DataManager.weatherCityDataArr[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
