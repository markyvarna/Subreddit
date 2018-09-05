//
//  PostController.swift
//  Subreddit
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation

class PostController {
    
    /*
   
     Create a constant called postsWithoutImages that will be set equal to the posts that are inside of our jsonDictionary. Pull them out using flatmap.
     Solution:
     let postsWithoutImages = jsonDictionary.data.children.flatMap( {$0.post} )
     Assign this array of posts to self.posts and call completion().

     */
    //URL: https://www.reddit.com/r/funny/.json
    
    
    //MARK: - Properties
    
    static let shared = PostController()
    private init() {}
    
    var posts: [Post] = []
    
    //URL: https://www.reddit.com/r/funny/.json
    let baseURL = URL(string: "https://www.reddit.com/r")
    
    
    //MARK: - Fetch Functions
    
    func fetchPosts(by searchTerm: String, completion: @escaping ([Post?]) -> Void) {
        
        //append components and unwrap url
        guard let url = baseURL?.appendingPathComponent(searchTerm).appendingPathComponent(".json") else {
            fatalError("🤬BAD BASE URL - check base url🤬")
        }
        print(url.absoluteString)
        
        //this is used to get Data back from the api
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                
                //if error throw to catch block, then handle data
                if let error = error {throw error}
                guard let newData = data else {completion([]); return}
                
                //decode and complete with obj
                let jsonDictionary = try JSONDecoder().decode(JSONDictionary.self, from: newData)
                let postsWithoutImages = jsonDictionary.dataDict.children.compactMap({$0.post})
                self.posts = postsWithoutImages
                completion(postsWithoutImages)
                
            } catch let error {
                
                print("🤬 Error dataTask Completion \(error), \(error.localizedDescription)🤬")
                completion([]); return
                
            }
            
        }.resume()
        
        
    }
    
}

//B1.)Know what you want to display (complete) to the user
//B2.) Call URLSession - so you can work backwards
//B3.) We need base url
//B4.) Build your url - Components ("/"), Querys [:], and extentsions (".")
