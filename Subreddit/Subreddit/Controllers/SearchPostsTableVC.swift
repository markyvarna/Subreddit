//
//  SearchPostsTableVC.swift
//  Subreddit
//
//  Created by Markus Varner on 9/4/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class SearchPostsTableVC: UITableViewController, UISearchBarDelegate {

    //MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK: - Properties
    var postCell: PostTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let post = PostController.shared.posts[indexPath.row]
        cell?.titleLabel.text = post.title
        cell?.upVotesLabel.text = "⬆️ \(post.numberOfUpvotes)"
        cell?.numOfCommentsLabel.text = "💬 \(post.numberOfComments)"
        
        
        return cell ?? UITableViewCell()
    }
    
    //MARK: - Actions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //get the searchTerm out of the searchBar, the call fetchPosts()
        guard let searchTerm = searchBar.text?.lowercased() else {return}
        PostController.shared.fetchPosts(by: searchTerm) { (posts) in
        
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
                
            }
        }
        
        searchBar.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
