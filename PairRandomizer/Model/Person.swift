//
//  Person.swift
//  PairRandomizer
//
//  Created by Huzaifa Gadiwala on 22/6/18.
//  Copyright © 2018 Huzaifa Gadiwala. All rights reserved.
//

import Foundation


class Person: Codable, Equatable {
    let name: String
    init(name: String){
        self.name = name
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
