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
    private var weatherDisplayModel = [WeatherDisplayModel]() // 8 elements
    private var currentDay = 0

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!

    @IBAction func btnNextTapped(_ sender: UIButton) {
        self.btnPrev.isHidden = false
        if self.currentDay < 4 {
            self.currentDay += 1
        }
        if self.currentDay == 4 {self.btnNext.isHidden = true}
        self.prepareTableViewDataSource()
        self.tableView.reloadData()
    }

    @IBAction private func btnPrevTapped(_ sender: UIButton) {
        self.btnNext.isHidden = false
        if self.currentDay > 0 {
            self.currentDay -= 1
        }
        if self.currentDay == 0 {self.btnPrev.isHidden = true}
        self.prepareTableViewDataSource()
        self.tableView.reloadData()
    }

    @objc private func didSwipeLeft(sender: UISwipeGestureRecognizer) {
        self.view.backgroundColor = .cyan
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeLeft(sender:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        self.lblCityName.text = self.cityWeatherData.city?.name
        prepareTableViewDataSource()
        self.btnPrev.isHidden = true
        self.tableView.reloadData()
    }

    private func prepareTableViewDataSource() {
        self.weatherDisplayModel.removeAll()
        let factor = self.currentDay*8
        guard let listArr = self.cityWeatherData.list else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = listArr[factor].dt_txt
        let date = dateFormatter.date(from: dateString!)
        let localDate = dateFormatter.string(from: date!)
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        let dateee = dateFormatter.string(from: date!)
        self.lblDate.text = "\(dateee)"
        print(localDate)
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
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            print(localDate)
            displayModel.heading = localDate
            self.weatherDisplayModel.append(displayModel)
        }
    }
}

extension CityDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDisplayModel.count
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
}
