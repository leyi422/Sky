//
//  SettingsTableViewCell.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingsTableViewCell"
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with vm: SettingsRepresentable) {
        label.text = vm.labelText
        accessoryType = vm.accessory
    }

}
