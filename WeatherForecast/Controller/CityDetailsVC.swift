//
//  CityDetailsVC.swift
//  WeatherForecast
//
//  Created by Malika Arora on 15/12/19.
//  Copyright © 2019 Malika Arora. All rights reserved.
//

import UIKit

class CityDetailsVC: UIViewController {
    var cityWeatherData = WeatherDataModel()
    private var weatherDisplayArr = [WeatherDisplayModel]() // corresponding to 8 cards
    private var currentDay = 0

    @IBOutlet private weak var lblCityName: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var btnPrev: UIButton!
    @IBOutlet private weak var btnNext: UIButton!

    @IBAction private func btnNextTapped(_ sender: UIButton) {
        self.btnPrev.isHidden = false
        if self.currentDay < 4 {
            self.currentDay += 1
        }
        if self.currentDay == 4 {self.btnNext.isHidden = true}
        self.prepareWeatherDisplayModelArray()
        self.tableView.reloadData()
    }

    @IBAction private func btnPrevTapped(_ sender: UIButton) {
        self.btnNext.isHidden = false
        if self.currentDay > 0 {
            self.currentDay -= 1
        }
        if self.currentDay == 0 {self.btnPrev.isHidden = true}
        self.prepareWeatherDisplayModelArray()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        self.lblCityName.text = self.cityWeatherData.city?.name?.uppercased()
        self.prepareWeatherDisplayModelArray()
        self.btnPrev.isHidden = true
        self.tableView.reloadData()
    }

    private func prepareWeatherDisplayModelArray() {
        self.weatherDisplayArr.removeAll()
        let factor = self.currentDay*8
        guard let listArr = self.cityWeatherData.list else {return}
        let dateString = self.getDateStringInProperFormat(dateString: listArr[factor].dt_txt ?? "")
        self.lblDate.text = "\(dateString)"
        for i in (0+factor..<8+factor) {
            var displayModel = WeatherDisplayModel()
            displayModel.temp = listArr[i].main?.temp
            displayModel.min_temp = listArr[i].main?.temp_min
            displayModel.max_temp = listArr[i].main?.temp_max
            displayModel.humidity = listArr[i].main?.humidity
            displayModel.speed = listArr[i].wind?.speed
            let weather = listArr[i].weather?[0]
            displayModel.weather = weather?.main ?? ""
            let date = Date(timeIntervalSince1970: TimeInterval(listArr[i].dt!))
            let timeString = self.getTimeInProperFormat(date: date)
            displayModel.heading = timeString
            self.weatherDisplayArr.append(displayModel)
        }
    }

    private func getDateStringInProperFormat(dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        guard let converteDate = date else {return ""}
        let dateString = dateFormatter.string(from: converteDate)
        return dateString
    }

    private func getTimeInProperFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = .current
        let timeString = dateFormatter.string(from: date)
        return timeString
    }
}

extension CityDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDisplayArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardCell") as? CardCell {
            cell.selectionStyle = .none
            cell.lblCityName.text = self.weatherDisplayArr[indexPath.row].heading
            cell.lblTemp.text = "\(self.weatherDisplayArr[indexPath.row].temp ?? 0)"
            cell.lblMinTemp.text = "\(self.weatherDisplayArr[indexPath.row].min_temp ?? 0)"
            cell.lblMaxTemp.text = "\(self.weatherDisplayArr[indexPath.row].max_temp ?? 0)"
            cell.lblHumidity.text = "\(self.weatherDisplayArr[indexPath.row].humidity ?? 0)"
            cell.lblWeatherType.text = self.weatherDisplayArr[indexPath.row].weather
            cell.lblWindSpeed.text = "\(self.weatherDisplayArr[indexPath.row].speed ?? 0)"
            return cell
        }
        return UITableViewCell()
    }
}
