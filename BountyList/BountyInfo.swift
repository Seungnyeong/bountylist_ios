//
//  BountyInfo.swift
//  BountyList
//
//  Created by SN on 2020/09/01.
//  Copyright © 2020 com.snkim. All rights reserved.
//

import UIKit

struct BountyInfo {
   let name : String
   let bounty : Int
   
   var image: UIImage? {
       return UIImage(named: "\(name).jpg")
   }
   
   init(name: String, bounty : Int) {
       self.name = name
       self.bounty = bounty
   }
}
