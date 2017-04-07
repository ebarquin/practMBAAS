//
//  MainTimeLine.swift
//  PracticaBoot4
//
//  Created by Juan Antonio Martin Noguera on 23/03/2017.
//  Copyright © 2017 COM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainTimeLine: UITableViewController {

    let cellIdentfier = "POSTSCELL"
    let rootRef = FIRDatabase.database().reference().child("Posts")
    var model: [Post] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        FIRAnalytics.setScreenName("MainTimeLine", screenClass: "Main")
        
        self.refreshControl?.addTarget(self, action: #selector(hadleRefresh(_:)), for: UIControlEvents.valueChanged)
        
//        rootRef.observe(FIRDataEventType.value, with: { ( snap ) in
//            
//            for postFB in snap.children {
//                
//                let post = Post(snap: (postFB as! FIRDataSnapshot))
//                self.model.append(post)
//                
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//            
//            
//        }) { (error) in
//            print(error)
//        }

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataFromFirebase()
        


        
        
    }
    
    func hadleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier, for: indexPath)
        
        
        cell.textLabel?.text = model[indexPath.row].title

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowRatingPost", sender: indexPath)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowRatingPost" {
            let vc = segue.destination as! PostReview
            // aqui pasamos el item selecionado
        }
    }
    
    //MARK: Utils:
    
    func getDataFromFirebase() -> [Post] {
        
        var posts: [Post] = []
        
        rootRef.observe(FIRDataEventType.value, with: { ( snap ) in
            
            for postFB in snap.children {
                
                let post = Post(snap: (postFB as! FIRDataSnapshot))
                posts.append(post)
                
            }
            //return posts
            self.model = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }) { (error) in
            print(error)
        }
        return posts
        
    }
    


}
