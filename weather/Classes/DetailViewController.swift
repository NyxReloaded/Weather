//
//  DetailViewController.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit

extension String {
    init(stringInterpolationSegment unit: MeasureUnit) {
        switch unit {
        case .none: self = ""
        case .degree: self = "°"
        case .percentage: self = "%"
        case .meterPerSecond: self = "m/s"
        case .hectoPascal: self = "hPa"
        }
    }
}
enum MeasureUnit {
    case none
    case degree
    case percentage
    case meterPerSecond
    case hectoPascal
}

protocol SectionType {
    static var all: [Self] { get }
}

protocol RowType {
    static var all: [RowType] { get }
    var label: String { get }
    var unit: MeasureUnit { get }
    func value(from forecast: Forecast?) -> String
}

extension RowType {
    
    var label: String {
        let name = String(describing: self).lowercased()
        let type = String(describing: type(of: self)).lowercased()
        return NSLocalizedString(type + "." + name, comment: "")
    }
    
    var unit: MeasureUnit {
        return .none
    }
}

class DetailViewController: UITableViewController {

    enum Sections: Int, SectionType {
        case main
        case wind
        case clould
        case rain
        case snow
        
        static let all: [Sections] = [.main, .wind, .clould, .rain, .snow]
    }
    
    struct Rows {
        enum Main: Int, RowType {

            case humidity
            case pressure
            
            static var all: [RowType] {
                return [Main.humidity, Main.pressure]
            }
            
            var unit: MeasureUnit {
                switch self {
                case .humidity:
                    return .percentage
                case .pressure:
                    return .hectoPascal
                }
            }
            
            func value(from forecast: Forecast?) -> String {
                let value: String
                switch self {
                case .humidity:
                    value = forecast?.mainInformation.humidity?.formatted ?? "-"
                case .pressure:
                    value = forecast?.mainInformation.pressure?.formatted ?? "-"
                }
                return "\(value) \(unit)"
            }
        }
        
        enum Wind: Int, RowType {
            case speed
            case degree
            
            static var all: [RowType] {
                 return [Wind.speed, Wind.degree]
            }
            
            var unit: MeasureUnit {
                switch self {
                case .speed:
                    return .meterPerSecond
                case .degree:
                    return .degree
                }
            }
            
            func value(from forecast: Forecast?) -> String {
                let value: String
                switch self {
                case .speed:
                    value = forecast?.wind.speed.formatted ?? "-"
                case .degree:
                    value = forecast?.wind.degree.formatted ?? "-"
                }
                return "\(value) \(unit)"
            }
        }
        
        enum Cloud: Int, RowType {
            case cloudiness
            
            static var all: [RowType] {
              return [Cloud.cloudiness]
            }
            
            var unit: MeasureUnit {
                switch self {
                case .cloudiness:
                    return .percentage
                }
            }
            
            func value(from forecast: Forecast?) -> String {
                let value: String
                switch self {
                case .cloudiness:
                    value = forecast?.clouds.cloudiness.formatted ?? "-"
                }
                return "\(value) \(unit)"
            }
        }
        
        enum Rain: Int, RowType {
            case volume
            
            static var all: [RowType] {
                return [Rain.volume]
            }
            
            var unit: MeasureUnit {
                switch self {
                case .volume:
                    return .none
                }
            }
            
            func value(from forecast: Forecast?) -> String {
                let value: String
                switch self {
                case .volume:
                    value = forecast?.rain?.last3HoursVolume.formatted ?? "-"
                }
                return "\(value) \(unit)"
            }
        }
        
        enum Snow: Int, RowType {
            case volume
            
            static var all: [RowType] {
                return [Snow.volume]
            }
            
            var unit: MeasureUnit {
                switch self {
                case .volume:
                    return .none
                }
            }
            
            func value(from forecast: Forecast?) -> String {
                let value: String
                switch self {
                case .volume:
                    value = forecast?.rain?.last3HoursVolume.formatted ?? "-"
                }
                return "\(value) \(unit)"
            }
        }
    }
    
    var currentWeather: Forecast? {
        didSet {
            tableView?.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Sections.all.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch Sections.all[section] {
        case .main:
            return Rows.Main.all.count
        case .wind:
            return Rows.Wind.all.count
        case .clould:
            return Rows.Cloud.all.count
        case .rain:
            return Rows.Rain.all.count
        case .snow:
            return Rows.Snow.all.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        let aRow = row(at: indexPath)
        cell.keyLabel.text = aRow.label + " :"
        cell.valueLabel.text = aRow.value(from: currentWeather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        configureBackgroundColor(on: view)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        configureBackgroundColor(on: view)
    }
    
    
    // MARK: - Helpers
    
    private func configureBackgroundColor(on view: UIView) {
        let backgroundView: UIView
        switch view {
        case is UITableViewHeaderFooterView:
            backgroundView = (view as! UITableViewHeaderFooterView).contentView
        case is UITableViewCell:
            backgroundView = (view as! UITableViewCell).contentView
        default:
            backgroundView = view
        }
        backgroundView.backgroundColor = UIColor.white
    }
    
    private func rows(at section: Int) -> [RowType] {
        let rows: [RowType]
        switch Sections.all[section] {
        case .main:
            rows = Rows.Main.all
        case .wind:
            rows =  Rows.Wind.all
        case .clould:
            rows =  Rows.Cloud.all
        case .rain:
            rows =  Rows.Rain.all
        case .snow:
            rows =  Rows.Snow.all
            
        }
        return rows
    }
    
    private func row(at indexPath: IndexPath) -> RowType {
        return rows(at: indexPath.section)[indexPath.row]
    }
    
}
