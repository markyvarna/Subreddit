//
//  PostController.swift
//  Subreddit
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class PostController {
    
  
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
    
    
    //MARK: - Fetch Images
    
    func fetchImages(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {completion(nil); return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                
                //handle error
                if let error = error {throw error}
                guard let newData = data else {throw NSError()}
                guard let image = UIImage(data: newData) else {completion(nil); return}
                print("🧐 are you on the main thread \(Thread.isMainThread)")
                completion(image)
                
            } catch let error {
                
                print("🤬 Error dataTask Completion \(error), \(error.localizedDescription)🤬")
                completion(nil)
                
            }
            
        }.resume()
    }
    
    
}

/*
 Check for and unwrap the data. Create a constant image by passing in the unwrapped data to the initializer on UIImage that takes data as an argument. (This initializer is also failable).
 
 Call completion whether or not you get an image. Choose whether you'll need to call completion(image) or completion(nil) in each part of your code where you will return out of this function.
 */
