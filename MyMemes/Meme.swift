//
//  Meme.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//
import UIKit
class Meme: NSObject, NSCoding {
    var title: String
    var type: String
    var rating: NSInteger
    let itemKey: String
    
    init(title: String, type: String, rating: Int) {
        self.title = title
        self.type = type
        self.rating = rating
        self.itemKey = UUID().uuidString
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        type = aDecoder.decodeObject(forKey: "type") as! String
        rating = aDecoder.decodeObject(forKey: "rating") as! NSInteger
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(itemKey, forKey: "itemKey")
    }
}

