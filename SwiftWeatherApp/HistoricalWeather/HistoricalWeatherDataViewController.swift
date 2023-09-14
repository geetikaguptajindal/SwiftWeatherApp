//
//  HistoricalWeatherDataViewController.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation
import Combine


final class HistoricalWeatherDataViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!

    var weatherViewModel: HistoricalWeatherViewModel!
    var weatherData: [WeatherLocalData] = []
    private var cancellable = Set<AnyCancellable>()

    private var tableViewWeather: UITableView  = {
        let tableViewWeather = UITableView()
        tableViewWeather.separatorStyle = .singleLine
        tableViewWeather.showsVerticalScrollIndicator = false
        return tableViewWeather
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        bindPublisher()
        weatherViewModel.getAllHistoricalWeather()
    }
    
    func bindPublisher(){
        weatherViewModel.output.weatherPublisher.sink { [weak self] weatherList in
            self?.weatherData = weatherList
            self?.tableViewWeather.reloadData()
        }.store(in: &cancellable)
    }
        
    
    private func setupUI(){
        
        self.navigationController?.navigationBar.isHidden = false
        titleLabel.text = (weatherViewModel.output.cityName + "Historical").uppercased()
        
        tableViewWeather.delegate = self
        tableViewWeather.dataSource = self
        self.view.addSubview(tableViewWeather)
        
        tableViewWeather.register(UINib(nibName: "HistoricalDataCell", bundle: nibBundle), forCellReuseIdentifier: "HistoricalDataCell")
        tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewWeather.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableViewWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableViewWeather.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableViewWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
}

//Mark- UITableViewDelegate, UITableViewDataSource
extension HistoricalWeatherDataViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        weatherData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricalDataCell", for: indexPath) as! HistoricalDataCell
        let weatherData = weatherData[indexPath.row]
        cell.setupView(weatherData: weatherData)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


