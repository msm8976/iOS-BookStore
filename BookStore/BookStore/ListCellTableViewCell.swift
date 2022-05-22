//
//  ListCellTableViewCell.swift
//  BookStore
//
//  Created by msm8976 on 2022/5/18.
//

import UIKit

class ListCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImg: UIImageView!
    
    @IBOutlet weak var cellName: UILabel!
    
    @IBOutlet weak var cellPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
