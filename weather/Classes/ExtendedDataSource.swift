//
//  ListDataSource.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class ExtendedDataSource: NSObject {
    let dailyForecasts: [DailyForecast]
    
    init(forecasts: [Forecast]) {
        dailyForecasts = ForecastHelper.dailyForecasts(forecasts: forecasts)
        super.init()
    }
    
    func registerCells(in tableView: UITableView) {
        tableView.register(cell: ForecastCell.self)
    }
}

extension ExtendedDataSource: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView DataSource & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecasts[section].forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: ForecastCell.self, for: indexPath)
        let aForecast = forecast(at: indexPath)
        configure(cell: cell, with: aForecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dailyForecasts[section].date.longFormatted
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: - Configuring Cells / Header Helpers
    
    private func configure(cell: ForecastCell, with forecast: Forecast) {
        cell.hourLabel.text = forecast.date.formattedHour
        cell.weatherIconImageView.af_setImage(withURL: forecast.weatherCondition.imageURL)
        cell.temperatureLabel.text = forecast.mainInformation.temperature.formatted + "°C"
        cell.weatherLabel.text = forecast.weatherCondition.description
        
        var infos: [String] = []
        let minTemp = forecast.mainInformation.minTemperature.formatted
        let maxTemp = forecast.mainInformation.maxTemperature.formatted + "°C"
        let temp = "\(minTemp) - \(maxTemp) "
        infos.append(temp)
        
        let windSpeed = forecast.wind.speed.formatted + " m/s."
        let wind = "\(windSpeed)"
        infos.append(wind)
        
        if let pressure = forecast.mainInformation.pressure?.formatted {
            infos.append(pressure + " hpa")
        }
        cell.detailLabel.text = infos.joined(separator: ", ")
    }

    
    // MARK: - Data Helpers
    private func forecast(at indexPath: IndexPath) -> Forecast {
        return dailyForecasts[indexPath.section].forecasts[indexPath.row]
    }
}
