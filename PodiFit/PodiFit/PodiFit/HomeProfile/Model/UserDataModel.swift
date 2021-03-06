//
//  UserDataModel.swift
//  PodiFit
//
//  Created by Nathanael Adolf Sukiman on 02/11/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import Foundation
import UIKit

class UserDataModel
{
    var Name: String!
    var weight: Int!
    var height: Int!
    var userIdPlan: [Int]?
    var img: Data
    
    init(Name: String,userIdPlan: [Int]?, weight: Int,height: Int,img: Data) {
        self.Name = Name
        self.weight = weight
        self.height = height
        self.userIdPlan = userIdPlan
        self.img = img
    }
}
