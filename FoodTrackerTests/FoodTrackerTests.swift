//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by csair on 2018/4/25.
//  Copyright © 2018年 Pop Team Epic. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
// mark meal class test
    
    
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds() {
        // Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0,hour: "1", minute: "2", price: "1.2")
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5,hour: "1", minute: "2", price: "1.2")
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitializationFails() {
        
        
        // Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1,hour: "1", minute: "2", price: "1.2")
        XCTAssertNil(negativeRatingMeal)
        
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6,hour: "1", minute: "2", price: "1.2")
        XCTAssertNil(largeRatingMeal)
        

        // Empty String
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0,hour: "1", minute: "2", price: "1.2")
        XCTAssertNil(emptyStringMeal)
        

    }
    


    
}
