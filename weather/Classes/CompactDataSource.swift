//
//  SummaryDataSource.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

class CompactDataSource: NSObject {
    let todayForecast: DailyForecast?
    let nextDaysForecasts: [DailyForecast]
    
    init(forecasts: [Forecast]) {
        let dailyForecasts = ForecastHelper.dailyForecasts(forecasts: forecasts)
        todayForecast = ForecastHelper.todayForecast(from: dailyForecasts)
        nextDaysForecasts = ForecastHelper.nextDailyForecasts(after: Date(), from: dailyForecasts)
        super.init()
    }
    
    func registerCells(in tableView: UITableView) {
        tableView.register(headerFooter: TodayForecastHeaderView.self)
    }
}

extension CompactDataSource: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nextDaysForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: WeekDayForecastCell.self, for: indexPath)
        let dailyforecast = dailyForecast(at: indexPath)
        configure(cell: cell, with: dailyforecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(headerFooter: TodayForecastHeaderView.self)
        configure(header: header, with: todayForecast)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = todayForecast else {
            return 0.0
        }
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: - Configuring Cells / Header Helpers
    
    private func configure(cell: WeekDayForecastCell, with dailyForecast: DailyForecast?) {
        guard let dailyForecast = dailyForecast else {
            return
        }
        cell.weekDayLabel.text = dailyForecast.date.weekday
        cell.minTemperatureLabel.text = ForecastHelper.minTemperature(in: dailyForecast.forecasts)?.formatted
        cell.maxTemperatureLabel.text = ForecastHelper.maxTemperature(in: dailyForecast.forecasts)?.formatted
        let url = ForecastHelper.midForecast(in: dailyForecast.forecasts).weatherCondition.imageURL
        cell.weatherIconImageView.af_setImage(withURL: url)
    }
    
    private func configure(header: TodayForecastHeaderView, with todayForecast: DailyForecast?) {
        guard let todayForecast = todayForecast else {
            return
        }
        header.weekdayLabel.text = todayForecast.date.weekday
        header.relativeDayLabel.text = todayForecast.date.relativeString
        header.minTempLabel.text = ForecastHelper.minTemperature(in: todayForecast.forecasts)?.formatted
        header.maxTempLabel.text = ForecastHelper.maxTemperature(in: todayForecast.forecasts)?.formatted
        header.hourCollectionView.dataSource = self
        header.hourCollectionView.reloadData()
    }
    
    // MARK: - Data Helpers
    private func dailyForecast(at indexPath: IndexPath) -> DailyForecast? {
        let idx = indexPath.row
        
        guard nextDaysForecasts.indices.contains(idx) else {
            return nil
        }
        return nextDaysForecasts[idx]
    }
}

extension CompactDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayForecast?.forecasts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: HourForecastCell.self, for: indexPath)
        
        if let forecast = forecast(at: indexPath) {
            cell.hourLabel.text = "\(forecast.date.hour)h"
            cell.temperatureLabel.text = forecast.mainInformation.temperature.formatted
            cell.weatherIconImageView.af_setImage(withURL: forecast.weatherCondition.imageURL)
        }
        
        return cell
    }
    
    // MARK: - Helpers
    
    private func forecast(at indexPath: IndexPath) -> Forecast? {
        return todayForecast?.forecasts[indexPath.item]
    }
    
}
