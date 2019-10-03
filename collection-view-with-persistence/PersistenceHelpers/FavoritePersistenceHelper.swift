//
//  FavoritePersistenceHelper.swift
//  collection-view-with-persistence
//
//  Created by David Rifkin on 10/3/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct FavoritePersistenceHelper {
    static let manager = FavoritePersistenceHelper()

    func save(newFavorite: Favorite) throws {
        try persistenceHelper.save(newElement: newFavorite)
    }

    func getFavorites() throws -> [Favorite] {
        return try persistenceHelper.getObjects()
    }
    
    //TODO: - Build out delete functionality
    func deleteFavorite(withID: Int) throws {
        do {
            let favorites = try getFavorites()
            let newFavorites = favorites.filter { $0.dogID != withID}
            try persistenceHelper.replace(elements: newFavorites)
        }
    }

    private let persistenceHelper = PersistenceHelper<Favorite>(fileName: "favorites.plist")

    private init() {}
}
