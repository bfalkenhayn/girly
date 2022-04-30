//
//  NewUserTableViewCell.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class NewUserTableViewCell: UITableViewCell {

    @IBOutlet weak var signDatesLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var signImageView: UIImageView!
   
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
