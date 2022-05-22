//
//  OrderCellTableViewCell.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/21.
//

import UIKit

class OrderCellTableViewCell: UITableViewCell {
    

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var num: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
