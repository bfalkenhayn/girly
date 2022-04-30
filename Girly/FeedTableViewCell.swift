//
//  FeedTableViewCell.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/24/22.
//

import UIKit
private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
    
    return dateFormatter
}()

protocol FeedTableViewCellDelegate: AnyObject {
    func likePress(sender: FeedTableViewCell)
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedTableViewCellDelegate?

    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var timePosted: UILabel!
    
    var comments:Comments!
    
    var cellLiked = false
    
    
    var post: Post! {
        didSet{
            
//            post.numberOfComments = comments.commentsArray.count
            promptLabel.text = post.prompt
            contentLabel.text = post.content
            post.numberOfComments == 1 ? "reply" : "replies"
            commentLabel.text = "\(post.numberOfComments) \(post.numberOfComments == 1 ? "reply" : "replies")"
            timePosted.text = dateFormatter.string(from: post.timePosted)

        }
    }
    
    
    @IBAction func likePressed(_ sender: UIButton) {
        print("likePressed")
       
        delegate?.likePress(sender: self)
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
