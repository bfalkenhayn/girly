//
//  CommentTableViewCell.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/25/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var comment:Comment! {
        didSet {

            print("comment is \(comment.content)")
            commentLabel.text = comment.content
           }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
