//
//  WeatherViewController.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation
import UIKit
import Combine

final class WeatherViewController: UIViewController {
    @IBOutlet private weak var weatherView: UIView!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var tempratureLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
        
    var weatherViewModel: WeatherViewModel!
    private var cancellable = Set<AnyCancellable>()

    // Left View
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Button_modal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "Button_modal"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindPublisher()
    }

    private func bindPublisher() {
        weatherViewModel.output.weatherPublisher.sink {[weak self] weatherData in
            self?.setupWeatherData(weatherData: weatherData)
        }.store(in: &cancellable)
        
        weatherViewModel.output.errorPublisher.sink { errorString in
            print(errorString)
        }.store(in: &cancellable)
    }
    
    func setupWeatherData(weatherData: WeatherLocalData) {
        humidityLabel.text = weatherData.formattedHumidity
        tempratureLabel.text = weatherData.formattedTemprature
        windLabel.text = weatherData.formattedWindSpeed
        descriptionLabel.text = weatherData.description
        
        // To do add on seperate thred
        let imgUrl = "https://openweathermap.org/img/wn/\(weatherData.icon).png"
        iconImageView.imageFromServerURL(urlString: imgUrl)
    }
    
    func setupWeatherViewStyle() {
        weatherView.layer.cornerRadius = 30
        weatherView.layer.shadowColor = UIColor.lightGray.cgColor
        weatherView.layer.shadowOpacity = 0.5
        weatherView.layer.shadowOffset = CGSize(width: 0, height: 0)
        weatherView.layer.shadowRadius = 10
    }
    
    func setupUI() {
        titleHeader.text = weatherViewModel.output.cityName.uppercased()
        
        self.view.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            leftButton.heightAnchor.constraint(equalToConstant: 100),
            leftButton.widthAnchor.constraint(equalToConstant: 102),
            leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        ])
        
        setupWeatherViewStyle()
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
