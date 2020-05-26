//
//  PersistanceManager.swift
//  GHFollowers
//
//  Created by Muhammad Umer Farooq on 24/05/2020.
//  Copyright © 2020 Muhammad Umer Farooq. All rights reserved.
//

import Foundation

enum PersistenceActionTypes {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(follower: Follower, actionType: PersistenceActionTypes, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
                case.success(var favorites):
                    switch actionType {
                        case .add:
                            guard !favorites.contains(follower) else {
                                completion(.alreadyInFavorites)
                                return
                            }
                            favorites.append(follower)
                        case .remove:
                            favorites.removeAll(where: {$0.login == follower.login})
                    }
                    completion(save(favorites: favorites))
                case.failure(let error):
                    completion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: "favorites") as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(GFError.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
