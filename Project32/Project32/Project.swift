//
//  Project.swift
//  Project32
//
//  Created by Mohammed Hamdi on 10/2/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import Foundation

class Project: NSObject, NSCoding {
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        subtitle = aDecoder.decodeObject(forKey: "subtitle") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(subtitle, forKey: "subtitle")
    }
}
