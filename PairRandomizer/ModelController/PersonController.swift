//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Huzaifa Gadiwala on 22/6/18.
//  Copyright © 2018 Huzaifa Gadiwala. All rights reserved.
//

import Foundation

class PersonController {
    
    // Singleton
    static let shared = PersonController()
    
    //Source of truth
    var people: [Person] = []
    
    init() {
        loadToPersistance()
    }

    
    // create
    func addPerson(name: String) {
        let person = Person(name: name)
        people.append(person)
        saveToPersistance()
    }
    
    func randomizePeople() {
        
        var randomize: [Person] = []
        for person in people {
            let index = Int(arc4random_uniform(UInt32(randomize.count)))
            randomize.insert(person, at: index)
        }
        people = randomize
    }
    
    // Read
    func fileURL() -> URL {
        //1) Use URL
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "people.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func loadToPersistance() {
        let jsondecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let people = try jsondecoder.decode([Person].self, from: data)
            self.people = people
        } catch let error {
            print("Error loading people from URL \(error.localizedDescription)")
        }
    }
    
    func saveToPersistance() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(people)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to persistent storage: \(error)")
        }
    }
    
    //D
    func remove(person: Person) {
        guard let personIndex = people.index(of: person) else {return}
        people.remove(at: personIndex)
        saveToPersistance()
    }
}
