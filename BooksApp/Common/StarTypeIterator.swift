//
//  StarTypeIterator.swift
//  BooksApp
//
//  Created by Alsu Faizova on 17.05.2023.
//

import Foundation

struct StarTypeIterator {
    
    private var tempRating: Double
    private var initialRating: Double
    
    init(rating: Double) {
        tempRating = rating
        initialRating = rating
    }
    
    mutating func set(newRating: Double) {
        tempRating = newRating
        initialRating = newRating
    }
    
    mutating func next() -> StarType {
        if tempRating >= 1 {
            tempRating -= 1
            return .filledStar
        } else if (tempRating != 0) && (tempRating < 1) {
            tempRating = 0
            return .halfStar
        }
        return .emptyStar
    }
    
    mutating func reset() {
        tempRating = initialRating
    }
}
