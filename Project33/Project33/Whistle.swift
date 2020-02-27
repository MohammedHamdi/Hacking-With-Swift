//
//  Whistle.swift
//  Project33
//
//  Created by Mohammed Hamdi on 10/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
