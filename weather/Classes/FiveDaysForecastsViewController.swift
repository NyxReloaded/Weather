//
//  FiveDayForecastViewController.swift
//  weather
//
//  Created by Mickael Laloum on 05/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import Foundation
import UIKit

class FiveDaysForecastsViewController: UIViewController {

    enum DisplayMode{
        case extended
        case compact
    }
    
    // UI
    @IBOutlet weak var tableView: UITableView!
    
    // Data
    var forecasts: [Forecast]? {
        didSet {
            if isViewLoaded {
                setupDataSource()
            }
        }
    }
    
    var displayMode: DisplayMode = .extended {
        didSet {
            if isViewLoaded {
                setupDataSource()
            }
        }
    }
    
    private var dataSource: (UITableViewDataSource & UITableViewDelegate)? {
        didSet {
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
            tableView.reloadData()
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupDataSource()   
    }

    // MARK: - UITableView DataSource & Delegate
    
    private func setupDataSource() {
        guard let forecasts = forecasts else {
            tableView?.dataSource = nil
            return
        }
        
        switch displayMode {
        case .extended:
            dataSource = ExtendedDataSource(forecasts: forecasts)
        case .compact:
            let compactDataSource = CompactDataSource(forecasts: forecasts)
            compactDataSource.registerCells(in: tableView)
            dataSource = compactDataSource
        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return .all
        }
        
        return .portrait
    }
}
