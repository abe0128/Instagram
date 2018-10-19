//
//  MainPageViewController.swift
//  Instagram
//
//  Created by Abraham De Alba on 10/2/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSignout(_ sender: Any)
    {
        PFUser.logOut()
        _ = PFUser.current()
        self.performSegue(withIdentifier: "LogoutSeg", sender: nil)
    }
    
    @IBAction func onCompose(_ sender: Any)
    {
        self.performSegue(withIdentifier: "composeSeg", sender: nil)
    }
    
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        // add refresh control to table view
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension;      tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        self.tableView.reloadData()
        fetchPosts()
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPosts()
        // ... Use the new data to update the data source ...
        // Reload the tableView now that there is new data
        tableView.reloadData()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func fetchPosts()
    {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground { (Post, error: Error?) -> Void in
            if let posts = Post {
                print("success fetch")
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print("fetch failed")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! PostCell
        let post = posts[indexPath.row]
        
        let caption = post.caption
        cell.postCaption.text = caption
        
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: {(data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.imagePost.image = image
                    }
                }
                else
                {
                    print(error!.localizedDescription)
                }
            })
        }
        return cell
        
    }
    
    func tableView(_tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if(sender != nil) {
//
//            let cell = sender as! UITableViewCell
//            if let indexPath = tableView.indexPath(for: cell) {
//                let post = posts[indexPath.row]
//                let detailViewController = segue.destination as! DetailViewController
//                detailViewController.post = post
//
//                let postCell = sender as! PostCell
//                detailViewController.postImage = postCell.postImage.image!
//            }
//        }
//    }

}
