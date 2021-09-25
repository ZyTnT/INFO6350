//
//  TableViewCell.swift
//  TableViewOfFruits
//
//  Created by 赵芷涵 on 9/24/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgFruit: UIImageView!
    @IBOutlet weak var lblFruit: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
