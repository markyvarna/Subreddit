//
//  PostTableViewCell.swift
//  Subreddit
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var upVotesLabel: UILabel!
    @IBOutlet var numOfCommentsLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: String? {
        didSet{
            updateViews()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func updateViews() {
        
        titleLabel.text = post?.title
        upVotesLabel.text = String(describing: post?.numberOfUpvotes)
        numOfCommentsLabel.text = String(describing: post?.numberOfComments)
        
    }

}

/*
 //update time label, name label, and enabled switch with alarm data
 nameLabel.text = alarm?.name
 timeLabel.text = alarm?.fireTimeAsString
 guard let alarmEnabled = alarm?.enabled else {return}
 alarmSwitch.setOn(alarmEnabled, animated: true)
 */
