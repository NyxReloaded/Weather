//
//  ForecastCell.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureBubbleView()
        resetView()
    }
    
    override func prepareForReuse() {
        resetView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureBubbleView()
    }
    
    private func configureBubbleView() {
        bubbleView.layer.masksToBounds = true
        bubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2.0
    }
    
    private func resetView() {
        hourLabel.text = nil
        weatherIconImageView.af_cancelImageRequest()
        weatherIconImageView.image = nil
        temperatureLabel.text = nil
        weatherLabel.text = nil
        detailLabel.text = nil
    }

}
