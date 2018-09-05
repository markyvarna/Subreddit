//
//  Round.swift
//  Subreddit
//
//  Created by Markus Varner on 9/5/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class Round: UIImageView {
    
        override func awakeFromNib() {
            setUpView()
        }
        func setUpView(){
            self.layer.cornerRadius = self.frame.width / 2
            self.clipsToBounds = true
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.purple.cgColor
        }
    

}
