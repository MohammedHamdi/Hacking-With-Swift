//
//  ViewController.swift
//  Project12
//
//  Created by Mohammed Hamdi on 8/31/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        //let array = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let dictionary = defaults.object(forKey: "savedDict") as? [String: String] ?? [String: String]()
    }


}

