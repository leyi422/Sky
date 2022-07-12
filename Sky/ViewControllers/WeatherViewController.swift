//
//  WeatherViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherContainerView: UIView!
    @IBOutlet weak var loadingFailedLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private func setupView() {
        weatherContainerView.isHidden = true
        loadingFailedLabel.isHidden = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

}
