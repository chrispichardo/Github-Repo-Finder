//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by christian pichardo on 2/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    let tableStructure: [[String]] = [["Minium Stars"]]
    
    
    var searchSettings = GithubRepoSearchSettings()
    //copy of settings
    var minimumStars : Int = 0
    
    weak var delegate: SettingsDelegate?
    
    @IBAction func cancelSettings(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        delegate?.settings(self, didChangeMinimumStars: self.minimumStars)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //set the slide value
        self.minimumStars = self.searchSettings.minStars
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableStructure.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell") as! SettingsCell
        if(indexPath.section == 0){
            let prefIdentifier = tableStructure[indexPath.section][indexPath.row]
            cell.preIdentifierLabel.text = prefIdentifier
            cell.minimunStarSlider.value = Float(self.searchSettings.minStars)
            cell.minimunStarSlider.minimumValue = 0
            cell.minimunStarSlider.maximumValue = 100000
            cell.minimunStarSlider.addTarget(self, action: "sliderChange:", forControlEvents: .ValueChanged)
        }
   // cell.delegate = self
    return cell
    
    }
    
    // get slider's value
    func sliderChange(sender: UISlider) {
        let currentValue = sender.value
        self.minimumStars = Int(currentValue)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
