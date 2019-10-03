//
//  Dog.swift
//  collection-view-with-persistence
//
//  Created by David Rifkin on 10/3/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Dog {
    let breed: String
    let image: String
    let id: Int
    
    static func getDogs() -> [Dog] {
        return [ Dog(breed:"collie", image: "collie", id: 1 ), Dog(breed: "Chinese Tibetan Mastiff", image: "chinese-tibetan-mastiff", id: 2)
        ]
    }
    
    static func getIDForNewDog() -> Int {
        let dogs = Dog.getDogs()
        let max = dogs.map{$0.id}.max() ?? 0
        return max + 1
    }
}
