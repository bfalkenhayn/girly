//
//  ListTableViewCell.swift
//  ToDo List
//
//  Created by Bridget Falkenhayn on 2/25/22.
//

import UIKit

private let timeFormatter: DateFormatter = {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "h:mma"
    return timeFormatter
}()

protocol ListTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
}


class ListTableViewCell: UITableViewCell {

    weak var delegate: ListTableViewCellDelegate?
    
//
//    @IBOutlet weak var checkBoxButton: UIButton!
//    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var toDoItem: Agenda! {
        didSet {
            activityLabel.text = toDoItem.activity
           
            timeLabel.text =  timeFormatter.string(from: toDoItem.time)
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
