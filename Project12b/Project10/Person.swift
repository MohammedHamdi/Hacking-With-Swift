//
//  Person.swift
//  Project10
//
//  Created by Mohammed Hamdi on 8/28/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
