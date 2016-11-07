//
//  HomeViewController.swift
//  weather
//
//  Created by Mickael Laloum on 03/11/2016.
//  Copyright © 2016 Mickael Laloum. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController {
    
    // UI
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView! {
        willSet {
            scrollView?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), context: nil)
        }
        didSet {
            scrollView?.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: [], context: nil)
        }
    }
    
    // Embedded View Controllers
    private var embededFiveDaysForecastsViewController: FiveDaysForecastsViewController! {
        didSet {
            // Forward data
            embededFiveDaysForecastsViewController.forecasts = forecasts
        }
    }
    private var embededDetailViewController: DetailViewController! {
        didSet {
            // Forward data
            embededDetailViewController.currentWeather = currentWeather
        }
    }
    
    // Data
    private var city: City?
    private var currentWeather: Forecast? {
        didSet {
            // Forward data
            embededDetailViewController.currentWeather = currentWeather
        }
    }
    private var forecasts: [Forecast]? {
        didSet {
            // Forward data
            embededFiveDaysForecastsViewController?.forecasts = forecasts
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    // MARK: - Fecthing Data
    
    private func fetchData() {
        
        loadingView.startAnimating()
        loadingView.isHidden = false
        embededFiveDaysForecastsViewController.view.isHidden = true
        
        let syncGroup = DispatchGroup()
        syncGroup.enter()
        Api.shared.getForecasts() { [weak self] result in
            syncGroup.leave()
            self?.forecasts = result.value?.forecasts
            DispatchQueue.main.async { [weak self] in
                self?.embededFiveDaysForecastsViewController.view.isHidden = false
            }
        }
        
        syncGroup.enter()
        Api.shared.getCurrentWeather { [weak self] result in
            syncGroup.leave()
            if let currentWeather = result.value {
                self?.city = currentWeather.city
                self?.currentWeather = currentWeather.forecast
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
        
        syncGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.loadingView.stopAnimating()
            self?.loadingView.isHidden = true
        }
        
    }

    private func updateUI() {
        cityLabel.text = city?.name
        if let currentWeather = currentWeather {
            descriptionLabel.text = currentWeather.weatherCondition.description
            temperatureLabel.text = currentWeather.mainInformation.temperature.formatted
        } else {
            descriptionLabel.text = nil
            temperatureLabel.text = "--"
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.destination {
        case is FiveDaysForecastsViewController:
            embededFiveDaysForecastsViewController = (segue.destination as! FiveDaysForecastsViewController)
        case is DetailViewController:
            embededDetailViewController = (segue.destination as! DetailViewController)
        default:
            break;
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func actionPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: NSLocalizedString("Mode d'affichage", comment: ""), message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.barButtonItem = sender
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Étendu", comment: ""), style: UIAlertActionStyle.default) { [weak self] _ in
                self?.embededFiveDaysForecastsViewController.displayMode = .extended
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Compact", comment: ""), style: UIAlertActionStyle.default) { [weak self] _ in
            self?.embededFiveDaysForecastsViewController.displayMode = .compact
        })
        present(alertController, animated: true)
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(UIScrollView.contentSize) {
            scrollView.contentOffset.x = CGFloat(pageControl.currentPage) * scrollView.frame.width;
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
 
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationItem.rightBarButtonItem?.isEnabled = (calculatedCurrentPage == 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else {
            return
        }
        
        updatePagination()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePagination()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePagination()
    }
    
    private var calculatedCurrentPage: Int {
        let pageWidth = scrollView.frame.size.width;
        let page = Int((scrollView.contentOffset.x + (0.5 * pageWidth)) / pageWidth)
        return page
    }
    
    private func updatePagination() {
        pageControl.currentPage = calculatedCurrentPage
    }
    
}
