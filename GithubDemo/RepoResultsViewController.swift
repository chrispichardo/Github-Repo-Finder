//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the UITableView
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 300
        //tableView.rowHeight = UITableViewAutomaticDimension

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    private func doSearch() {

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            self.repos = newRepos
            // Print the returned repositories to the output window
            for repo in newRepos {
               // print(repo)
            }
            
            self.tableView.reloadData()

            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if((self.repos) != nil){
            return self.repos.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RepoCell", forIndexPath: indexPath) as! RepoCell
        
        cell.descriptionLabel.text = self.repos[indexPath.row].repoDescription
        cell.nameLabel.text = self.repos[indexPath.row].name
        cell.starLabel.text = "\(self.repos[indexPath.row].stars!)"
        cell.forkLabel.text = "\(self.repos[indexPath.row].forks!)"
        let avatarURL = NSURL(string: self.repos[indexPath.row].ownerAvatarURL!)
        cell.ownerImageView.setImageWithURL(avatarURL!)
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nav = segue.destinationViewController as! UINavigationController
        let settingsVC = nav.topViewController as! SettingsViewController
            settingsVC.searchSettings = self.searchSettings
            settingsVC.delegate = self
                
    }
    
    func settings( settings: SettingsViewController, didChangeMinimumStars minimunStars: Int?){

        if let stars = minimunStars {
            self.searchSettings.minStars = stars
            NSLog("stars =  \(self.searchSettings.minStars)")
            //reload data
            doSearch()

        }
    }

}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}