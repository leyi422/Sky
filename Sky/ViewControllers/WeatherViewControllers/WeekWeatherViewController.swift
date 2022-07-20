//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var weekWeekWeatherTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension WeekWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
