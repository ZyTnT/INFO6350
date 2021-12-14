//
//  ChampionTableViewCell.swift
//  New_FinalProject
//
//  Created by 赵芷涵 on 12/11/21.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {

    @IBOutlet weak var imgChampion: UIImageView!
    
    
    @IBOutlet weak var lblChampion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
