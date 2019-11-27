//
//  AnnounceCell.swift
//  1612082_cuoiKy
//
//  Created by LV on 1/17/19.
//  Copyright © 2019 DangNH. All rights reserved.
//

import UIKit

class AnnounceCell: UITableViewCell {
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
