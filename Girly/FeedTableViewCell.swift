//
//  FeedTableViewCell.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import UIKit

protocol FeedTableViewCellDelegate: class {
    func likePress(sender: FeedTableViewCell)
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedTableViewCellDelegate?

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var post: Post! {
        didSet{
            promptLabel.text = post.prompt
            contentLabel.text = post.content
            post.numberOfComments == 1 ? "reply" : "replies"
            commentLabel.text = "\(post.numberOfComments) \(post.numberOfComments == 1 ? "reply" : "replies")"
            
        
        }
    }
    
    @IBAction func likePressed(_ sender: Any) {
        if likeButton.imageView?.image == UIImage(systemName: "heart.fill") {
            likeButton.imageView?.image = UIImage(systemName: "heart")
        } else {
            delegate?.likePress(sender: self)
            likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
}
