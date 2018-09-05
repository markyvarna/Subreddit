//
//  Post.swift
//  Subreddit
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

struct Post: Decodable {
    
    let title: String
    let thumbnailEndpoint: String
    let numberOfUpvotes: Int
    let numberOfComments: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case title
        case thumbnailEndpoint = "thumbnail"
        case numberOfUpvotes = "ups"
        case numberOfComments = "num_comments"
        
    }
}
//JSONDictionary
struct JSONDictionary: Decodable {
    
    let dataDict: DataDictionary
    
    //DataDictionary
    struct DataDictionary: Decodable {
        
        let children: [PostDictionary]
        
        //PostDictionary
        struct PostDictionary: Decodable {
            
            let post: Post
            
        }
    }
    
}
