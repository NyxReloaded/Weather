//
//  TodayForecastCellTableViewCell.swift
//  weather
//
//  Created by Mickael Laloum on 03/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class TodayForecastHeaderView: UITableViewHeaderFooterView {

    // UI
    @IBOutlet var weekdayLabel: UILabel!
    @IBOutlet var relativeDayLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var hourCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
        configureHourCollectionView()
        resetView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
    
    private func configureHourCollectionView() {
        hourCollectionView.register(cell: HourForecastCell.self)
    }
    
    private func resetView() {
        weekdayLabel.text = nil
        relativeDayLabel.text = nil
        maxTempLabel.text = nil
        minTempLabel.text = nil
        hourCollectionView.dataSource = nil
    }

}

