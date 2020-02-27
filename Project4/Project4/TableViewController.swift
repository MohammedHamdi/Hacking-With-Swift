//
//  TableViewController.swift
//  Project4
//
//  Created by Mohammed Hamdi on 8/25/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //var websites = ["apple.com", "hackingwithswift.com"]
    var websites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose a website"
        
        if let websiteURL = Bundle.main.url(forResource: "websites", withExtension: "txt") {
            if let websiteString = try? String(contentsOf: websiteURL) {
                websites = websiteString.components(separatedBy: "\n")
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)

        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Web") as? ViewController {
            vc.websites = websites
            vc.website = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
