//
//  HistoricalDataCell.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation

final class HistoricalDataCell: UITableViewCell {
    
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!
    
    func setupView(weatherData: WeatherLocalData) {
        tempLabel.text = "Temprature: " + weatherData.formattedTemprature
        windLabel.text = "Wind Speed: " + weatherData.formattedWindSpeed
        timeStampLabel.text = weatherData.fetchTimeStamp
    }
}
