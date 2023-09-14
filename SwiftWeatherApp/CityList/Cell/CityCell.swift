//
//  HistoricalDataCell.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation

protocol CityDelegate: AnyObject {
    func goToHistoricalView(cityObj: City)
}

final class CityCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: CityDelegate?
    var cityObj: City!
    
    func setupView(cityObj: City) {
        nameLabel.text = cityObj.city
        self.cityObj = cityObj
    }
    
    @IBAction func goToHistoricalRecord() {
        self.delegate?.goToHistoricalView(cityObj: cityObj)
    }
}
