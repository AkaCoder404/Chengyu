//
//  FavoritesManager.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/26/24.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    private let favoritesKey = "favoriteIdioms"
    
    static let shared = FavoritesManager()
    
    @Published var favorites: Set<String>
    
    private init() {
        let savedFavorites = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        favorites = Set(savedFavorites)
    }
    
    func addFavorite(id: String) {
        favorites.insert(id)
        saveFavorites()
    }
    
    func removeFavorite(id: String) {
        favorites.remove(id)
        saveFavorites()
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }
}
