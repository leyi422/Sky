//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humid: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
