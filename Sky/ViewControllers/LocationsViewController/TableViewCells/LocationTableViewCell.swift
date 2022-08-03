//
//  LocationTableViewCell.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    static let reuseIdentitifier = "LocationCell"
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with viewModel: LocationRepresentable) {
        label.text = viewModel.labelText
    }

}
