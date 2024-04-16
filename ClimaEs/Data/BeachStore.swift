//
//  BeachStore.swift
//  ClimaEs
//
//  Created by Sergei Kornilov on 30/03/2024.
//

import UIKit

public final class BeachesStore {
    public static let shared: BeachesStore = .init()
    
    // Lista de playas añadidas por el usuario. Las playas añadidas se guardan en UserDefaults
    public var favoriteBeaches: [Beach] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    private init() {
        loadFavorites()
    }
    
    
    // MARK: - Lifecycle
    // Añade una playa a tu lista de favoritas si aún no está en ella
    public func addFavoriteBeach(_ beach: Beach) {
        guard !favoriteBeaches.contains(where: { $0.beachId == beach.beachId }) else {
            print("La playa ya está en los favoritos.")
            return
        }
        favoriteBeaches.append(beach)
        print("#BeachStore: Beach añadió: \(beach.beachName)")
        
    }
    // Elimina una playa de la lista de favoritos
    public func removeFavoriteBeach(at index: Int) {
        guard index < favoriteBeaches.count else { return }
        favoriteBeaches.remove(at: index)
    }
    
    // Carga las playas seleccionadas desde UserDefaults
    private func loadFavorites() {
        guard let data = userDefaults.data(forKey: "favoriteBeaches") else { return }
        do {
            favoriteBeaches = try decoder.decode([Beach].self, from: data)
        } catch {
            print("Error de [descodificación] de las playas seleccionadas", error)
        }
    }
    
    // Guarda los cambios de las playas seleccionadas en UserDefaults
    private func saveFavorites() {
        do {
            let data = try encoder.encode(favoriteBeaches)
            userDefaults.setValue(data, forKey: "favoriteBeaches")
        } catch {
            print("Error en la [codificación] de las playas seleccionadas para preservar", error)
        }
    }
    
}
