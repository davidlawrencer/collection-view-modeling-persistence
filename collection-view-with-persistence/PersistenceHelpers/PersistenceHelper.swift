//
//  PersistenceHelper.swift
//  collection-view-with-persistence
//
//  Created by David Rifkin on 10/3/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    //TODO: - Build out delete functionality
//    func replace(elements: [T]) throws {
//
//    }
//
//    func delete(element: T, withID: Int) throws {
//        do {
//            let elements = try getObjects()
//            let newElements = elements.filter { $0.id != withID}
//            save(newFavorite: <#T##Favorite#>)
//        }
//    }
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    private func filePathFromDocumentsDirectory(name: String) -> URL {
        return documentsDirectory.appendingPathComponent(name)
    }
    
    private let fileName: String
        
    private var url: URL {
        return filePathFromDocumentsDirectory(name: fileName)
    }
}
