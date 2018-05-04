//
//  meal.swift
//  FoodTracker
//
//  Created by csair on 2018/5/3.
//  Copyright © 2018年 Pop Team Epic. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Meal: NSObject, NSCoding {
    // mark properties
    var name : String
    var rating : Int
    var photo : UIImage?
    var hour: Int
    var minute: Int
    var price: Float
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    

    //MARK: Types
    
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let price = "price"
        static let hour = "hour"
        static let minute = "minute"
    }
    

    
    // mark initialization
    init?(name: String, photo: UIImage?, rating:Int, hour:String, minute:String, price:String) {
    
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // hour and minute must not be empty
        guard !hour.isEmpty else{
            return nil
        }
        guard !minute.isEmpty else{
            return nil
        }
        
        // price must not be empty and should at most have a point
        guard !price.isEmpty else {
            return nil
        }
        let strArray = price.split(separator: ".")
        guard strArray.count<3 else{
            return nil
        }

        self.photo = photo
        self.name = name
        self.rating = rating
        self.hour = Int(hour)!
        self.minute = Int(minute)!
        self.price = Float(price)!
    }
    //mark nscoding
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(hour, forKey: PropertyKey.hour)
        aCoder.encode(minute, forKey: PropertyKey.minute)
        aCoder.encode(price, forKey: PropertyKey.price)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        let hour = aDecoder.decodeInteger(forKey: PropertyKey.hour)
        let minute = aDecoder.decodeInteger(forKey: PropertyKey.minute)
        let price = aDecoder.decodeFloat(forKey: PropertyKey.price)
        
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, hour: String(hour), minute: String(minute), price: String(describing: price))
        
    }
    


}
