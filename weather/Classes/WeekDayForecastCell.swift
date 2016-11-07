//
//  DayCell.swift
//  weather
//
//  Created by Mickael Laloum on 03/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class WeekDayForecastCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    private func resetView() {
        weekDayLabel.text = nil
        weatherIconImageView.af_cancelImageRequest()
        weatherIconImageView.image = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
    }

}
