//
//  ApplierCell.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/16/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit

class ApplierCell: UITableViewCell {

    @IBOutlet weak var jobApllier: UILabel!
    @IBOutlet weak var typeApllier: UILabel!
    @IBOutlet weak var payApllier: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
