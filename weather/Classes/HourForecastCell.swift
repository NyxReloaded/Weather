//
//  HourCell.swift
//  weather
//
//  Created by Mickael Laloum on 03/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    private func resetView() {
        hourLabel.text = nil
        weatherIconImageView.af_cancelImageRequest()
        weatherIconImageView.image = nil
        temperatureLabel.text = nil
    }
}
